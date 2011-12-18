class ToE::Model::PointLink < ToE::Model::Link
  
  attr_accessor :element, :element_type
  
  def initialize
    super
  end
  
  def layer
    target
  end
  
end
