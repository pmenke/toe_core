# encoding: utf-8

# This is a porter for the ShortTextGrid file format by Praat.
class ToE::Porter::ElanPorter

  include ::ToE::Model
  
  def initialize
    
  end
  
  # try to read the Praat document at input_file into a ToE document.
  # options:
  #   :include_empty_annotations => (true|false)
  
  def self.read(input_file, pPorter=nil, options = {})
    
    # todo try and rescue all possible encodings
    begin
      ToE::Porter::ElanPorter.read_with_encoding(input_file, "UTF-8", pPorter, options)
    rescue => err
      puts "ERROR! #{err}"
    end
    
  end
  
  # Reads the given input file with a specified encoding.
  # @param input_file the name of the file to read
  # @param encoding the (external) encoding to use for reading
  # @param porter if not nil, this porter object will be used
  # @param options a hash of settings for the import
  def self.read_with_encoding(input_file, encoding, porter=nil, options = {})
    include ToE::Model 
          
    puts "rb:#{encoding}"
    f = File.open(input_file, "rb:#{encoding}:UTF-8")
    xmldoc = ::Nokogiri::XML(f)
    
    document = ToEDocument.new
    document.id = "toedocument"
    scale = Scale.new(document)
    scale.id = "timeline"
    scale.name = "timeline"
    scale.mode = :Ratio
    scale.continuous = true
    scale.unit = "s"
    document.scale_set << scale
    
    
    # 1. find time slots, store
    timeslots = Hash.new
    xmldoc.xpath("//TIME_ORDER/TIME_SLOT").each do |t|
      slot = t["TIME_SLOT_ID"]
      val  = t["TIME_VALUE"].to_i
      timeslots[slot] = val
    end
    # timeslots.each do |k,v|
    #   puts "%20s :: %d" % [k,v]
    # end
    
    # 2. get layers
    
    xmldoc.xpath("//ANNOTATION").each do |n|
      # puts n
    end
    
    layerHash = Hash.new
    
    xmldoc.xpath("//TIER").each do |t|
      # @todo (DEFAULT_LOCALE="en") (LINGUISTIC_TYPE_REF="default-lt")
      tierID = t["TIER_ID"]
      
      layer = Layer.new(document)
      layer.name = tierID
      layer.id = ToE::Util::to_xml_id(tierID)
      
      layerHash[tierID] = layer
      
      t.xpath("./ANNOTATION").each do |annoContainer|
        
        annoContainer.xpath("child::*").each do |anno|
          if anno.name == "ALIGNABLE_ANNOTATION"
            # ANNOTATION_ID
            # TIME_SLOT_REF1
            # TIME_SLOT_REF2
            
            annoVal = anno.xpath("./ANNOTATION_VALUE/text()").first.to_s
            # puts anno.xpath("./ANNOTATION_VALUE/text()").first
            if annoVal!=nil && annoVal.strip != "" 
              event = Event.new #(document)
              interval = IntervalLink.new
              interval.min = anno["TIME_SLOT_REF1"].to_f
              interval.max = anno["TIME_SLOT_REF2"].to_f
              interval.target = scale
              event.links << interval
              layerlink = LayerLink.new
              layerlink.target = layer
              event.links << layerlink
              event.data = annoVal
              
              document.event_set.add(event)
            end
          end
          
        end
        
      end
      
      document.layer_structure << layer
      
      if t["PARENT_REF"]
        parent = layerHash[t["PARENT_REF"]]
        if parent
          document.layer_structure.connect(parent, layer)
        end
      end
      
    end
    
        
    return document
    
  end
  
end
