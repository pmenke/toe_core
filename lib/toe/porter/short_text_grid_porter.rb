# encoding: utf-8

# This is a porter for the ShortTextGrid file format by Praat.
class ToE::Porter::ShortTextGridPorter

  include ::ToE::Model
  
  def initialize
    
  end
  
  # try to read the Praat document at input_file into a ToE document.
  # options:
  #   :include_empty_annotations => (true|false)
  
  def self.read(input_file, pPorter=nil, options = {})
    
    # todo try and rescue all possible encodings
    begin
      ToE::Porter::ShortTextGridPorter.read_with_encoding(input_file, "UTF-16BE", pPorter, options)
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

      # TODO now do some work with the data.
      # document looks as follows:
      # ----------------
      # File type = ""
      # Object class = ""
      # 
      # double : min_time
      # double : max_time
      # <exists>
      # int : number of tiers
      # - string : type of tier
      #   string : id of tier
      #   double : min_time
      #   double : max_time
      #   int : number of annotations
      #   - double : min_time
      #   - double : max_time
      #   - string : value
          
    puts "rb:#{encoding}"
    f = File.open(input_file, "rb:#{encoding}:UTF-8")
    
    document = ToEDocument.new
    document.id = "toedocument"
    scale = Scale.new # TODO complete scale object
    scale.id = "timeline"
    scale.name = "timeline"
    scale.mode = :Ratio
    scale.continuous = true
    scale.unit = "s"
    document.scale_set << scale
    
    fileType = f.gets.strip
    objectClass = f.gets.strip
    f.gets # blank line
    global_min = f.gets.to_f
    global_max = f.gets.to_f
    f.gets # <exists>
    
    # get the numbers of tiers in this document.
    numberOfTiers = f.gets.to_i
    
    
    numberOfTiers.times do |tierNumber|
      #puts "TIER: #{tierNumber}"
      
      tierType = f.gets.strip
      tierName = f.gets.strip
      tier_min = f.gets.to_f
      tier_max = f.gets.to_f
      
      #puts "minmax: %i, %i" % [tier_min, tier_max]
      
      #puts "tier name: %s" % tierName
      
      #puts "document: %s" % document.to_s
       
      # create layer object from that tier
      #puts "layer constructor before"
      layer = Layer.new(document)
      #puts "layer constructor done"
      
      #puts "strip quotes"
      layer.name = ToE::Util::strip_quotes(tierName)
      
      #puts "to xml id"
      layer.id = ToE::Util::to_xml_id(tierName)
      
      #puts "layer: %s" % layer.name
      
      numberOfAnnotations = f.gets.to_i
      
      numberOfAnnotations.times do |annotationNumber|
        
        anno_min = f.gets.to_f
        anno_max = f.gets.to_f
        anno_val = f.gets.strip.gsub(/^"/, "").gsub(/"$/, "")
        
        #puts "  #{anno_val} [#{anno_min}--#{anno_max}]"
        
        event = Event.new #(document)
        interval = IntervalLink.new
        interval.min = anno_min
        interval.max = anno_max
        interval.target = scale
        event.links << interval
        layerlink = LayerLink.new
        layerlink.target = layer
        event.links << layerlink
        event.data = anno_val
        
        document.event_set.add(event)
      end
      
      document.layer_structure << layer
      
    end
    
    while line = f.gets
      puts "LINE THAT WE MISSED!"
      #puts "#{line.encoding.name} -- #{line.force_encoding('US-ASCII')}"
      line = line.force_encoding("UTF-8")
      if line.index("\"")!=nil
        #puts line
      end
    end
    
    return document
    
  end
  
end