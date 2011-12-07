# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::LayerLink < ToE::Model::Link
  
  def initialize
    super
  end
  
  def layer
    target
  end
  
end
