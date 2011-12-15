class ToE::Model::LayerConnector < ToE::Model::BasicToEObject

  attr_accessor :source, :target,
          :id, :name,
          :cardinality, :order, :role
  
end