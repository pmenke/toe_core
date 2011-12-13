# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::LayerStructure < ToE::Model::BasicToEObject
  
  attr_reader :layers
  
  def initialize
    super
    @layers = []
    @connectors = Hash.new #@todo put real objects here
    
  end
  
  def add_layer(layer)
    @layers << layer
  end
  
  def size
    @layers.size
  end
  
  def connect(source_layer, target_layer, options = {})
    #@todo connection code
  end
  
end
