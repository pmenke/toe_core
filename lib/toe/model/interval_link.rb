# A link pointing to a scale interval target.

class ToE::Model::IntervalLink < ToE::Model::Link
  
  attr_accessor :min, :max
  
  # FIXME Doc me!
  def initialize
    super
  end
  
  #@todo (med) create interval module!
  # operates on min and max values
  # calculates any other property out of those two values
  
end
