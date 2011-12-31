class ToE::Model::Data
  
  # @return [String|Integer|Double|Boolean|Array|Hash] Ruby representation of this data element
  def self.read(element)
    case element.name
    when "String"
      return ::ToE::Model::Data.read_string(element)
    when "Map"
      return ::ToE::Model::Data.read_map(element)
    end
  end
  
  
  def self.read_string(element)
    return element.content
  end
  
  def self.read_map(element)
    x = Hash.new
    
    element.children.each do |c|
      if c.element?
        key = c.attributes["key"]
        val = ::ToE::Model::Data.read(c)
        unless val==nil
          x[key] = val
        end
      end
      return x
    end
  end
  
end