class ToE::Model::Link < ToE::Model::BasicToEObject
  
  attr_accessor :target, :role, :order
  
  #@todo order field must use a number
  
  def initialize
    super
    role = ""
    order = 0
  end
  
end