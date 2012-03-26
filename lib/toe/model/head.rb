# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::Head < ToE::Model::BasicToEObject
  
  attr_accessor :features
  
  def initialize
    @features = Array.new  
  end
  
  # TODO (low) helper methods to get features by type, by key, etc.
  
  def <<(feature)
    @features << feature
  end
  
  def size
    @features.size
  end
  
end
