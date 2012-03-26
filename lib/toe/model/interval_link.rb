class ToE::Model::IntervalLink < ToE::Model::Link
  
  attr_accessor :min, :max
  
  def initialize
    super
  end
  
  def layer
    target
  end
  
  #@todo (med) create interval module!
  # operates on min and max values
  # calculates any other property out of those two values
  
end
