# The {ToE::Model} module comprises all classes that are needed to express
# ToE documents and their components.
# The central element is the {ToEDocument} class. It contains all methods 
# necessary for the creation of ToE documents from scratch:
#
#  doc = ToEDocument.new
#  doc.create_scale({:mode=>:Nominal, :unit=>:entity})
#  doc.create_layer({:name=>"Objects", :content_structure=>"Graph"})
#  doc.read_events(File.new("./foo.bar"))
#
# You can also use the constructor although its use is not encouraged:
#
#  scale = Scale.new({:mode => :Nominal})

module ToE::Model
  
end