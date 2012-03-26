# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::Layer < ToE::Model::BasicToEObject

  attr_accessor :content_structure, :data_type, :id, :name
  attr_accessor :document
  
  def initialize(pDocument)
    super()
    
    puts "layer constructor"
    
    @events = []
    @document=pDocument
  end


  def add_event(e)
    @events << e
  end
  
  # get all events inside a layer
  def events
    #@todo method to get all events out of a layer.
    # later: get it from eventdocument=>layerstructure (?)
   #@events
   @events ||= @document.event_set.select{|e| e.layers.include?(self)}
    
  end
  
  
end
