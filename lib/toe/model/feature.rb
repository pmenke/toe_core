# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::Feature < ToE::Model::BasicToEObject
  
  attr_accessor :type, :key, :value
  
  def initialize
    
  end
  
  def has_key?
    return @key.nil?
  end
  
end
