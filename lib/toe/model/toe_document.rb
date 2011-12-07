# To change this template, choose Tools | Templates
# and open the template in the editor.

include ToE::Model

class ToE::Model::ToEDocument < ToE::Model::BasicToEObject
  
  
  attr_accessor :head, :scale_set, :referenced_object_list, :agent_list, :layer_structure, :event_set
  
  def initialize
  
    @head = Head.new
    @scale_set = ScaleSet.new
    @agent_list = Hash.new #@todo create actual AgentList class
    @layer_structure = Hash.new #@todo create actual LayerStructure class
    @event_set = EventSet.new

  end
  
  
  def describe
    puts "** ToEDocument"
    puts "**   #{scale_set.size} scales"
    puts "**   #{event_set.size} events"
  end
end
