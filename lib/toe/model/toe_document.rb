# To change this template, choose Tools | Templates
# and open the template in the editor.

include ToE::Model

class ToE::Model::ToEDocument < ToE::Model::BasicToEObject
  
  
  attr_accessor :head, :scale_set, :referenced_object_list, :agent_list, :layer_structure, :event_set
  
  def initialize
  
    @head = Head.new
    @scale_set = ScaleSet.new
    
    # TODO other new objects
    
  end
  
  
  
end
