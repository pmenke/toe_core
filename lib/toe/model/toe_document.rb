# To change this template, choose Tools | Templates
# and open the template in the editor.

include ToE::Model

class ToE::Model::ToEDocument < ToE::Model::BasicToEObject
  
  attr_accessor :id
  attr_accessor :head, :scale_set, :referenced_object_list, :agent_list, :layer_structure, :event_set
  attr_accessor :porter
  
  def initialize
    @porter = nil
    @head = Head.new
    @scale_set = ScaleSet.new
    @agent_list = Hash.new #@todo (med) create actual AgentList class
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
      %w(id name mode role unit dimension continuous?).each do |att|
        result << iline(6, "@#{att}: #{scale.send(att)}")
      end
    end
    result << iline(2, "#{layer_structure.size} layers")
    layer_structure.layers.each do |layer|
      result << iline(4, "layer #{layer.inspect}")
      %w(id name content_structure data_type).each do |att|
        result << iline(6, "@#{att}: #{layer.send(att)}")
      end
    end
    result << iline(2, "#{event_set.size} events")
    event_set.events.each do |event|
      result << iline(4, "event #{event}")
      event.links.each do |link|
        result << iline(4, "link #{link}")
        #%w(id name order role).each do |att|
        #  result << iline(6, "@#{att}: #{link.send(att)}")
        #end
        #export target as object reference.
        result << iline(6, ">target: #{link.target}") unless link.target.nil?
      end
      result << iline(6, "@id: #{event.id}")
      result << iline(6, "data: #{event.data}")
    end
    result
  end
  
  def iline(ind, line)
    #puts ind.class.name
    #puts line.class.name
    return "**#{indent(ind)}#{line}\n"
  end
  
  def indent(num=0)
    #puts num
    #puts num.class.name
    return "  "*num
  end
  
end
