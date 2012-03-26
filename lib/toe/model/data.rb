class ToE::Model::Data
  
  TRUTH_VALS = %w(true TRUE 1 yes)
  
  # @return [String|Integer|Double|Boolean|Array|Hash] Ruby representation of this data element
  # @todo (hi) implement import of the following fields: Integer, Double, Boolean, List
  def self.read(element)
    case element.name
    when "String"
      return ::ToE::Model::Data.read_string(element)
    when "Int"
      return ::ToE::Model::Data.read_int(element)
    when "Float"
      return ::ToE::Model::Data.read_float(element)
    when "Bool"
      return ::ToE::Model::Data.read_bool(element)
    when "List"
      return ::ToE::Model::Data.read_list(element)
    when "Map"
      return ::ToE::Model::Data.read_map(element)      
    end
  end
  
  # @todo (hi) method read_int
  # @todo (hi) read_double
  # @todo (hi) read_bool
  # @todo (hi) read_list
  
  # attempts to read a string from an element
  # @param   element (XML::Node)  the element to read
  # @return             (String)  the string value from the element
  def self.read_string(element)
    return element.content
  end
  
  # attempts to read an integer value from an element
  # @param   element (XML::Node)  the element to read
  # @return            (Integer)  the integer value from the element
  def self.read_int(element)
    return element.content.to_i
  end
  
  # attempts to read a float value from an element
  # @param   element (XML::Node)  the element to read
  # @return              (Float)  the float value from the element
  def self.read_float(element)
    return element.content.to_f
  end  
  
  # attempts to read a boolean value from an element
  # @param   element (XML::Node)  the element to read
  # @return               (Bool)  the bool value from the element
  def self.read_bool(element)
    return (TRUTH_VALS.include?(element.content) ? true : false)
  end
  
  
  def self.read_list(element)
    result = Array.new
    element.each_element do |e|
      result << ::ToE::Model::Data.read(e)
    end
    return result
  end
  
  def self.read_map(element)
    x = Hash.new
    element.each_element do |e|
      key = e.attributes["key"]
      val = ::ToE::Model::Data.read(e)
      unless (key==nil || val==nil)
        x[key] = val
      end
    end
    return x
  end
  
end