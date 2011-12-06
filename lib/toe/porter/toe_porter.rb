# To change this template, choose Tools | Templates
# and open the template in the editor.

#require 'xml'

class ToE::Porter::ToEPorter

  include ::ToE::Model
  
  public
  
    def initialize
      
      
      
    end
  
    def self.read(input_file)
      parser = ::LibXML::XML::Parser.file(input_file)
      document = parser.parse
      porter = self.new
      return self.read_xml(document.root)
    end

    def self.write(output_file)

    end
  
    def self.read_xml(root)
      
      root.each_element do |x|
        
        puts "    -- #{x.name}"
        
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
      
      puts @head.name
      puts @scale_set.name
      puts @referenced_object_list.name
      puts @agent_list.name
      puts @layer_structure.name
      puts @event_set.name
      
      
      edoc = ToEDocument.new
      
      # 1. parse head
       puts @head
       puts @head.class.name
       @head.each_element do |e|
         if e.name == "Feature"
           f = Feature.new
           adopt e, f, %w{key type}
           puts "  & Feature #{f}"
           e.each_element do |child|
             process_data child
           end
         end
       end
      
      # 2. parse scale set
      
      @scale_set.each_element do |e|
        if e.name == "Scale"
          puts "  & Scale #{e.attributes.to_a}"
          scale = Scale.new
          adopt(e, scale, ["mode", "unit"])
          edoc.scale_set << scale
        end
      end
      
      #puts edoc.scale_set.inspect
      
      return edoc
    end
    
    private 
    
    def self.adopt(xml_node, target_object, attribute_names)
      attribute_names.each do |name|
        target_object.send("#{name}=", xml_node.attributes[name])
      end
    end
  
    # @todo do some actual work here!
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
