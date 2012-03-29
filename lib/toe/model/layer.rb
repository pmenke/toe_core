# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::Layer < ToE::Model::BasicToEObject

  attr_accessor :content_structure, :data_type, :id, :name
  attr_accessor :document
  
  def initialize(pDocument)
    super()
    puts "layer constructor"
    @document=pDocument
  end

  def add_event(e)
    document.event_set.add(e)
  end
  
  # get all events inside a layer
  def events
    return document.event_set.find_by_layer(self)
  end
  
end
