# To change this template, choose Tools | Templates
# and open the template in the editor.

include ToE::Model

class ToE::Model::ToEDocument < ToE::Model::BasicToEObject
  
  
  attr_accessor :head, :scale_set, :referenced_object_list, :agent_list, :layer_structure, :event_set
  
  def initialize
  
    @head = Head.new
    @scale_set = ScaleSet.new
    @agent_list = Hash.new #@todo create actual AgentList class
    @layer_structure = LayerStructure.new
    @event_set = EventSet.new

  end
  
  
  def describe
    result = ""
    result << iline(0, "ToEDocument")
    result << iline(2, "#{head.size} features in head")
    head.features.each do |feature|
      result << iline(4, "feature #{feature.inspect}")
    end
    result << iline(2, "#{scale_set.size} scales")
    scale_set.scales.each do |scale|
      result << iline(4, "scale #{scale.inspect}")
    end
    result << iline(2, "#{layer_structure.size} layers")
    layer_structure.layers.each do |layer|
      result << iline(4, "layer #{layer.inspect}")
    end
    result << iline(2, "#{event_set.size} events")
    event_set.events.each do |event|
      result << iline(4, "event #{event}")
      event.links.each do |link|
        result << iline(4, "link #{link}")
      end
    end
    result
  end
  
  def iline(indent, line)
    return "**#{indent(indent)}#{line}\n"
  end
  
  def indent(num=0)
    return "  "*num
  end
  
end
