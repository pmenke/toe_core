require "singleton"

class ToE::Gen::RandomDocumentGenerator
  include Singleton

  @@DEFAULT_GENERATE_PARAMS = { :scales=>2,
                                :layers=>8,
                                :events=>32 }

  @@SYLLABLES = %w(k g p b t d s l).collect{|c| %w(a e i o u y ie ai).collect{|v|  ["n", "m", "r", ""].collect{ |o| "#{c}#{v}#{o}"}}}.flatten

  @@MAX_WORD_LENGTH = 4
  
  def word 
    l = 1 + rand(@@MAX_WORD_LENGTH)
    w = ""
    l.times do
      w << @@SYLLABLES[rand(@@SYLLABLES.size)]
    end 
    w
  end
  
  def generate(params={})
    params = @@DEFAULT_GENERATE_PARAMS.merge(params)

    doc = ToE::Model::ToEDocument.new
    params[:scales].times do |n|
      scale = Scale.new
      scale.id = "scale#{n}"
      scale.name = scale.id
      scale.mode = "ratio"
      scale.role = ""
      scale.unit = "s"
      scale.dimension = ""
      scale.continuous = true
      doc.scale_set.add(scale)
    end
    
    params[:layers].times do |n|
      layer = Layer.new(doc)
      layer.id = "layer#{n}"
      layer.name = layer.id
      layer.content_structure = "undefined"
      layer.data_type = "undefined"
      doc.layer_structure.add_layer(layer)
    end
    
    params[:events].times do |n|
      e = Event.new
      e.id = "event#{n}"
      e.data = word
      llink = LayerLink.new
      llink.target = doc.layer_structure.layers[rand(doc.layer_structure.size)]
      e.add_link llink
      slink = IntervalLink.new
      slink.target = doc.scale_set.scales[rand(doc.scale_set.size)]
      slink.min = 0.0
      slink.max = 0.0
      e.add_link slink
      doc.event_set.add e
    end
    
    #puts word
    
    doc
    
  end
  
  

end