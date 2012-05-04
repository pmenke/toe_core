# To change this template, choose Tools | Templates
# and open the template in the editor.

#require 'xml'

class ToE::Porter::ToEPorter

  include ::ToE::Model
  
  public
  
    def initialize
      # stores mapping between xml ids and created objects
      @ids_to_objects = Hash.new
      # stores mapping between created objects and xml ids
      @objects_to_ids = Hash.new
      # store tasks
      @tasks = Array.new
    end
    
    # save a pair of id and object in convenience hashes
    def store(id, object)
      @ids_to_objects[id] = object
      @objects_to_ids[object] = id
      #puts "....Stored #{id} = #{object}."
    end
    
    def resolve(object)
      #puts "String?         #{object.is_a?(String)}"
      #puts "BasicToEObject? #{object.is_a?(BasicToEObject)}"
      
      if object.is_a?(String)
        # resolve the object for the given id
        return @ids_to_objects[object]
      elsif object.is_a?(BasicToEObject)
        # resolve the id for the given object
        #@objects_to_ids.keys.each do |k|
        #  puts "    #{k}"
        #end
        return @objects_to_ids[object]
      end
      return nil
    end
    
    def storage_size
      return @ids_to_objects.size
    end
    
    def list_storage
      w = @ids_to_objects.keys.collect{|x| x.length}.max
      #puts w
      #puts w.class.name
      return @ids_to_objects.keys.collect { |x| "%#{w}s  :  %-64s" % [x,@ids_to_objects[x]] }.join("\n")
    end
    
    def add_task(command, params = {})
      @tasks << { :command => command }.merge(params)
    end
    
    def add_set_target_task(id, target_object, target_method)
      add_task :SetTarget, { :id => id, :target_object => target_object, :target_method => target_method }
    end
    
    def perform_tasks
      # puts "  performing post-import tasks"
      performed_tasks = []
      @tasks.each do |task|
        case task[:command]
        when :SetTarget
          needed_object = resolve(task[:id])
          task[:target_object].send(task[:target_method], needed_object)
          performed_tasks << task
        end
      end
      # puts "  post-import tasks done."
      @tasks = @tasks - performed_tasks
    end
    
    def self.instance
      self.new
    end
    
    # create a new instance by importing the given XML file
    def self.read(input_file, pPorter=nil, options = {})
      parser = ::LibXML::XML::Parser.file(input_file)
      document = parser.parse
      if pPorter.nil?
        porter = ::ToE::Porter::ToEPorter.instance
      else
        porter = pPorter
      end
      #document.root.attributes["id"] = "EventDocument"
      edoc = porter.read_xml(document.root)
      # resolve open tasks
      porter.perform_tasks
      edoc.porter=nil
      return edoc
    end

    # export this instance to the given XML file.
    # @param (File) the file to write to. will be created
    #               if it does not exist.
    def write(document, output_file)
      #puts "porter write."
      File.open(output_file, 'w') do |file|
        #puts "get engine, then write"
        file.write(write_engine.render(Object.new, {:doc => document}))
      end
      return true
    end
  
    def write_engine
      @write_engine ||= create_engine
    end
    
    def create_engine
      # puts "create engine."
      engine = ::Haml::Engine.new(File.read(File.join(File.dirname(__FILE__),'..','..','..','assets','haml','toe.xml.haml')))
      engine.options[:attr_wrapper] = '"'
      # puts "Engine: #{engine}"
      return engine
    end
    
    # imports data from an XML toe document into this instance
    def read_xml(root)
      id = root.attributes["id"]
      root.each_element do |x| 
        case x.name
        when "Head"
          @head=x  
        when "ScaleSet"
          @scale_set = x
        when "ReferencedObjectList"
          @referenced_object_list = x
        when "AgentList"
          @agent_list = x
        when "LayerStructure"
          @layer_structure = x
        when "EventSet"
          @event_set = x
        end
      end
      
      #puts @head.name
      #puts @scale_set.name
      #puts @referenced_object_list.name
      #puts @agent_list.name
      #puts @layer_structure.name
      #puts @event_set.name
      
      edoc = ToEDocument.new
      adopt root, edoc, %w{id}
      edoc.porter = self
      store id, edoc
      
      
      # 1. parse head
      @head.each_element do |e|
        if e.name == "Feature"
          # import feature
          f = Feature.new
          store e.attributes["id"], f
          adopt e, f, %w{id key type}
          data_element = e.find_first("child::*")

          # import values.
          case data_element.name
            when "String"
              f.value = data_element.content
            when "List"
              f.value = data_element.find("child::*").collect{|x| x.content}
            when "Map"
              h = Hash.new
              data_element.find("child::*").each do |c|
                h[c.attributes["key"]] = c.content
              end
              f.value = h
          end
          edoc.head << f
        end
      end
      
      # 2. parse scale set
      
      @scale_set.each_element do |e|
        x = "Scale each element #{e}"
        if e.name == "Scale"
          scale = Scale.new(edoc)
          store e.attributes["id"], scale
          adopt(e, scale, ["id", "name", "mode", "unit"])
          if e.attributes.collect{|a| a.value}.include?("continuous") && e.attributes["continuous"]=="true"
            scale.continuous = true
          else
            scale.continuous = false
          end
          edoc.scale_set << scale
        end
      end
      
      # 4. parse layer stuff
      find_children_by_name(@layer_structure, "Layer").each do |layer_el|
        #puts "Layer: #{layer_el}"
        layer = Layer.new(edoc)
        adopt(layer_el, layer, %w{id name})
        #puts "LAYER NAME: #{layer.name}"
        layer.content_structure = layer_el.attributes["contentStructure"]
        layer.data_type = layer_el.attributes["dataType"]
        edoc.layer_structure << layer
        store layer.id, layer
      end
      
      find_children_by_name(@layer_structure, "LayerConnector").each do |lc_el|
        #puts "LayerConnector: #{lc_el}"
      end
      
      #puts edoc.scale_set.inspect
      
      @event_set.each_element do |el|
        if el.name == "Event"
          ev = Event.new
          adopt el, ev, %w(id)
          store ev.id, ev
          # LayerLinks, ScaleLinks EventLinks
          el.each_element do |subel|
            x = "Link element #{subel}"
            if subel.name == "LinkList"
              subel.each_element do |link_el|
                target_object = resolve(link_el.attributes["target"])
                s = link_el.to_s
                if link_el
                  if link_el.name == "LayerLink"
                    # puts "  >>  link to Layer"
                    l = LayerLink.new
                    adopt link_el, l, %w(id name)
                    l.target = target_object
                    #puts "  >>  links: #{ev.links.size}"
                    ev.links << l
                    #puts "  >>  links: #{ev.links.size}"
                    target_object.add_event(ev)
                  end
                  if link_el.name == "EventLink"
                    l = EventLink.new
                    adopt link_el, l, %w(id name)
                    if target_object == nil
                      add_set_target_task(link_el.attributes["target"], l, :target)
                    else
                      l.target = target_object
                    end
                    ev.links << l
                  end
                  if link_el.name == "PointLink"
                    l = PointLink.new
                    l.target = target_object unless target_object.nil?
                    adopt link_el, l, %w(id name element order role)
                    l.element_type = link_el.attributes["elementType"]
                    ev.links << l
                  end
                  if link_el.name == "IntervalLink"
                    l = IntervalLink.new
                    l.target = target_object unless target_object.nil?
                    adopt link_el, l, %w(min max order role)
                    #l.element_type = link_el.attributes["elementType"]
                    ev.links << l
                  end
                end
              end
            end
          end
          #workaround!!!
          # ev.data = find_children_by_name(el, "Data")[0].to_s
          
          # read data recursively
          # Data/(String,Int,Float,Boolean,List,Map)
          data_el = find_children_by_name(el, "Data")[0]
          data_sub_el = data_el.find("./*")[0]
          
          #puts "Data EL:     #{data_el}"
          #puts "Data Sub EL: #{data_sub_el}"

          unless data_sub_el == nil
            ev.data = ::ToE::Model::Data.read(data_sub_el)
          end
          edoc.event_set.add ev
        end
      end
      # puts "edoc import done."
      return edoc
    end
    
    private 
    
    def adopt(xml_node, target_object, attribute_names)
      attribute_names.each do |name|
        if (xml_node.attributes[name] != nil && target_object.respond_to?("#{name}="))
          target_object.send("#{name}=", xml_node.attributes[name])
        else
          a = xml_node.attributes[name] != nil
          b = target_object.respond_to? "#{name}="
          #puts "xml node has the attribute '#{name}'     : #{a} #{xml_node}"
          #puts "target object does respond to '#{name}=' : #{b}"
        end
      end
    end
  
    # This is just a placeholder method.
    def process_data(element)
      if element.element?
        if element.name == "String"
          puts "String!"
        end
        if element.name == "Map"
          puts "Hash!"
        end
        if element.name == "List"
          puts "Array!"
        end
      end
      if element.text?
        puts "Text!"
      end
    end
    
    def find_children_by_name(element, name) 
      element.find("./*[local-name()='#{name}']")
    end
    
    def find_grandchildren_by_name(element, n1, n2)
      element.find("./*[local-name()='#{n1}']/*[local-name()='#{n2}']")
    end
    
    def find_descendants_by_name(element, name) 
      element.find(".//*[local-name()='#{name}']")
    end
    
end
