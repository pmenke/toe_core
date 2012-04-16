# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::Feature < ToE::Model::BasicToEObject
  
  attr_accessor :type, :key, :value
  
  # FIXME Doc me!
  def initialize
    
  end
  
  # FIXME Doc me!
  def has_key?
    return @key.nil?
  end
  
  # FIXME Doc me!
  def inspect
    return "Feature #{type} ##{key} : #{value}"
  end
  
end
