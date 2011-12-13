# To change this template, choose Tools | Templates
# and open the template in the editor.

#require 'xml'

class ToE::Porter::ToEPorter

  include ::ToE::Model
  
  public
  
    # needs a mapping between xml ids and already created objects
    
  
    def initialize
      
      # stores mapping between xml ids and created objects
      @ids_to_objects = Hash.new
      
      # stores mapping between created objects and xml ids
      @objects_to_ids = Hash.new
      
    end
    
    def store_id_and_object(id, object)
      @ids_to_objects[id] = object
      @objects_to_ids[object] = id
    end
    
  
    def self.read(input_file)
      parser = ::LibXML::XML::Parser.file(input_file)
      document = parser.parse
      porter = self.new
      return porter.read_xml(document.root)
    end

    def self.write(output_file)

    end
  
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
      
      # 1. parse head
      @head.each_element do |e|
         if e.name == "Feature"
           # import feature
           f = Feature.new
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
        if e.name == "Scale"
          scale = Scale.new
          adopt(e, scale, ["id", "name", "mode", "unit"])
          if e.attributes["continuous"]=="true"
            scale.continuous = true
          else
            scale.continuous = false
          end
          edoc.scale_set << scale
        end
      end
      
      # 4. parse layer stuff
      
      @layer_structure.find("Layer").each do |layer|
        puts "Layer: #{layer}"
      end
      
      #puts edoc.scale_set.inspect
      
      @event_set.each_element do |el|
        if el.name == "Event"
          ev = Event.new
          edoc.event_set.add ev
          
          # @todo add links to object
          # LayerLinks, ScaleLinks EventLinks
          
          el.each_element do |subel|
            if subel.name == "LinkList"
              subel.each_element do |link_el|
                if link_el.name == "LayerLink"
                  #puts "    link to Layer"
                  l = LayerLink.new
                  l.target = link_el.attributes["target"]
                  ev.links << l
                end
                if link_el.name == "EventLink"
                  #puts "    link to Event"
                end
                if link_el.name == "PointLink"
                  #puts "    link to Point"
                end
                if link_el.name == "IntervalLink"
                  #puts "    link to Interval"
                end
              end
            end
          end
          
        end
      end
      
      return edoc
    end
    
    private 
    
    def adopt(xml_node, target_object, attribute_names)
      attribute_names.each do |name|
        target_object.send("#{name}=", xml_node.attributes[name])
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
end
