
# The Event class is the central data element in a ToE document.
# It links data chunks to specific points or intervals on one or
# more scales.
class ToE::Model::Event < ToE::Model::BasicToEObject
  
  # data object that can hold different object structures
  # @return [Data] data object of this event
  attr_reader :data
  
  # up link to the event set
  # @return [EventSet] event set container object of this event
  attr_reader :event_set
  
  # container for links
  # @return [Array] data object of this event
  attr_reader :links
  
  
  public
  
  # create a new, empty and unlinked Event object.
  def initialize
    #puts "Hello World"
    @data=nil
    @event_set=nil
    @links=Array.new
    #puts "  Links: #{links}"
  end
  
  # set a new data object for this event
  # @param [Data] the data object to set
  # @return [Boolean] true iff assignment worked
  def data=(new_data)
    @data = new_data
  end
  
  # set a new event set parent for this event
  # @param [EventSet] the new event set
  def event_set=(new_event_set)
    @event_set = new_event_set
  end

  # replace the existing link array with new one
  def links=(new_links)
    @links = new_links
  end
  
  # inserts a new link into this event
  # @param [Link] the link to be inserted 
  def add_link(new_link)
    @links << new_link unless @links.include? new_link
  end
  
  #
  # @return [LayerLink[]] an array of the layer links of this event
  def layer_links
    @links.select{|l| l.is_a? LayerLink}
  end
  
  #
  # @return [EventLink[]] an array of the event links of this event
  def event_links
    @links.select{|l| l.is_a? EventLink}
  end
  
  #
  # @return [PointLink[]] an array of the point links of this event
  def point_links
    @links.select{|l| l.is_a? PointLink}
  end
  
  #
  # @return [IntervalLink[]] an array of the interval links of this event
  def interval_links
    @links.select{|l| l.is_a? IntervalLink}
  end
  
  # retrieves and returns all linked layers from the layer links
  # @return [Layer[]] an array of layers this event is linked to
  def layers
    #@todo get array of layers from layer link objects
    # puts "  Links: #{@links.size}"
    layer_links.collect{|l| l.layer}.uniq
  end
  
  # retrieves and returns all linked scales from the scale links
  # @return [Scale[]] an array of scales this event is linked to
  def scales
    #@todo get array of scales from scale link objects
    (point_links+interval_links).collect{|l| l.target.is_a? Scale}.uniq
  end
  
  # retrieves and returns all linked events from the event links
  # @return [Event[]] an array of events this event is linked to
  def events
    #@todo get hash (:role => event) from event links
    #but: multiple role assignments!
    #now: return event array.
    event_links.collect{|l| l.event}.uniq
  end
  
end