# represents the collection of scales that are contained
# in a toe document.
class ToE::Model::ScaleSet < ToE::Model::BasicToEObject
  
  attr_accessor :scales
  
  def initialize
    @scales = Array.new
  end
  
  # this is an instance method. doc this!
  # @author Peter Menke
  #@return boolean 
  def include?(scale)
    @scales.include?(scale)
  end
  
  alias :contains? :include?

  def size
    return @scales.size
  end
  
  def <<(scale)
    unless @scales.include? scale
      @scales << scale
    end
  end
  
  # remove the given scale from this scale set
  # @param [Scale] scale The scale object to remove
  def -(scale)
    if @scales.include? scale
      @scales.remove(scale)
    end
  end
  
  # remove the given scale from this scale set
  # @param [Integer]index The scale object to remove
  def [](index)
    return @scales[index]
  end
  
end