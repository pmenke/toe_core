# encoding: utf-8

# This is a porter for the ShortTextGrid file format by Praat.
class ToE::Porter::TextGridPorter

  include ::ToE::Model
  
  def initialize
    
  end
  
  # try to read the Praat document at input_file into a ToE document.
  # options:
  #   :include_empty_annotations => (true|false)
  
  def self.read(input_file, pPorter=nil, options = {})
    
    # todo try and rescue all possible encodings
    begin
      ToE::Porter::TextGridPorter.read_with_encoding(input_file, "UTF-16BE", pPorter, options)
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

      # now do some work with the data.
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
    scale = Scale.new(document)
    scale.id = "timeline"
    scale.name = "timeline"
    scale.mode = :Ratio
    scale.continuous = true
    scale.unit = "s"
    document.scale_set << scale
    
    # now: start to read the file.
    
    fileType = f.gets.strip
    objectClass = f.gets.strip
    f.gets # blank line
    global_min = f.gets.to_f
    global_max = f.gets.to_f
    f.gets # <exists>
    
    size_spec = f.gets.strip
    
    size_match = size_spec.match(/\d+/)
    size_spec = size_match[0].to_i if size_match
    
    puts size_spec
    
    # next line: item []: - skip
    f.gets
    
    for tier_num in (1..size_spec)
      
      # read tier item line, drop it
      f.gets
      
      puts "class"
      tierClass = f.gets.match(/"(.*)"/)[1]
      puts "name"
      tierName  = f.gets.match(/"(.*)"/)[1] 
      puts "xmin"
      tierXmin = f.gets.match(/(\d+(\.\d+)?)/)[1].to_f 
      puts "xmax"
      tierXmax = f.gets.match(/(\d+(\.\d+)?)/)[1].to_f 
      puts "size"
      tierSize = f.gets.match(/size\s*=\s*(\d+)/)[1].to_i 
      
      [tierClass, tierName, tierXmin, tierXmax, tierSize].each do |k|
        puts " - %s" % k
      end
      
      layer = Layer.new(document)
      #puts "strip quotes"
      layer.name = tierName
      #puts "to xml id"
      layer.id = ToE::Util::to_xml_id(tierName)
      
      for anno_num in (1..tierSize)
        
        # read :
        
        # intervals [n]:
        # xmin = \dd
        # xmax  = \dd
        # text = "s"
         
        f.gets
        
        annoMin = f.gets.match(/(\d+(\.\d+)?)/)[1].to_f
        
        annoMax = f.gets.match(/(\d+(\.\d+)?)/)[1].to_f
        
        annoVal = f.gets.match(/"(.*)"/)[1]
        
        puts "%f, %f, %s" % [annoMin, annoMax, annoVal]
        
        if annoVal.strip != ""
          event = Event.new #(document)
          interval = IntervalLink.new
          interval.min = annoMin
          interval.max = annoMax
          interval.target = scale
          event.links << interval
          layerlink = LayerLink.new
          layerlink.target = layer
          event.links << layerlink
          event.data = annoVal
          
          document.event_set.add(event)
        end
        
      end
      
      document.layer_structure << layer
      # return
      
    end

   
    while line = f.gets
      puts "LINE THAT WE MISSED!"
      # puts "#{line.encoding.name} -- #{line.force_encoding('US-ASCII')}"
      line = line.force_encoding("UTF-8")
      if line.index("\"")!=nil
        #puts line
      end
    end
    
    return document
    
  end
  
end
