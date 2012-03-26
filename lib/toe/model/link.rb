class ToE::Model::Link < ToE::Model::BasicToEObject
  
  attr_accessor :target, :role, :order
  
  #@todo (low) order field must use a number, look into that when importing!
  
  def initialize
    super
    role = ""
    order = 0
  end
  
end