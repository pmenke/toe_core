class ToE::Model::PointLink < ToE::Model::Link
  
  attr_accessor :element
  
  def initialize
    super
  end
  
  def layer
    target
  end
  
end
