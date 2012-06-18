
# The Link class is the generic class for all relations that have an event as its source.
# Links may have a target object, roles, ordering numbers, and additional fields.

class ToE::Model::Link < ToE::Model::BasicToEObject
  
  attr_accessor :target, :role, :order
  
  #@todo (low) order field must use a number, look into that when importing!
  
  def initialize
    super
    role = ""
    order = 0
  end
  
end