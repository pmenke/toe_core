# A link pointing to a layer target.

class ToE::Model::LayerLink < ToE::Model::Link
  
  def initialize
    super
  end
  
  def layer
    target
  end
  
end
