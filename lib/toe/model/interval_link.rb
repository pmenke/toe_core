# FIXME Doc me!
class ToE::Model::IntervalLink < ToE::Model::Link
  
  attr_accessor :min, :max
  
  # FIXME Doc me!
  def initialize
    super
  end
  
  # todo layer ist falsch
  # FIXME Doc me!
  def layer
    target
  end
  
  #@todo (med) create interval module!
  # operates on min and max values
  # calculates any other property out of those two values
  
end
