# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::LayerStructure < ToE::Model::BasicToEObject
  
  attr_reader :layers
  attr_reader :connectors
  
  def initialize
    super
    @layers = Array.new
    @connectors = Array.new
  end
  
  def <<(layer)
    add_layer(layer)
  end
    
  def add_layer(layer)
    @layers << layer
  end
  
  def size
    @layers.size
  end
  
  def connect(source_layer, target_layer, options = {})
    connector = LayerConnector.new
    connector.source = source_layer
    connector.target = target_layer
    #@todo (low) priority, role, other stuff?
    add_connector(connector)
  end
  
  def add_connector(connector_object)
    connectors.add connector_object
  end
  
end
