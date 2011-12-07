# To change this template, choose Tools | Templates
# and open the template in the editor.

include ToE::Model

class ToE::Model::ToEDocument < ToE::Model::BasicToEObject
  
  
  attr_accessor :head, :scale_set, :referenced_object_list, :agent_list, :layer_structure, :event_set
  
  def initialize
  
    @head = Head.new
    @scale_set = ScaleSet.new
    @agent_list = Hash.new #@todo
    @layer_structure = Hash.new #@todo
    @event_set = Hash.new #@todo
    
    # TODO other new objects
  end
  
  
  def describe
    puts "ToEDocument"
    puts "  #{scale_set.size} scales"
    puts "  #{event_set.size} events"
  end
end
