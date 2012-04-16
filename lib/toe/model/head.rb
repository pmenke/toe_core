# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::Head < ToE::Model::BasicToEObject
  
  # FIXME Doc me!
  attr_accessor :features
  
  # FIXME Doc me!
  def initialize
    @features = Array.new  
  end
  
  # TODO (low) helper methods to get features by type, by key, etc.
  
  # FIXME Doc me!
  def <<(feature)
    @features << feature
  end
  
  # FIXME Doc me!
  def size
    @features.size
  end
  
end
