
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
    puts "Hello World"
    @data=nil
    @event_set=nil
    @links=Array.new
    puts "  Links: #{links}"
  end
  
  # set a new data object for this event
  # @param [Data] the data object to set
  # @return [Boolean] true iff assignment worked
  def data=(new_data)
    @data = new_data
  end
  
  # set a new event set parent for this event
  def event_set=(new_event_set)
    @event_set = new_event_set
  end

  # replace the existing link array with new one
  def links=(new_links)
    @links = new_links
  end
  
  def add_link(new_link)
    @links << new_link unless @links.include? new_link
  end
  
  # retrieves and returns all linked layers from the layer links
  def layers
    #@todo get array of layers from layer link objects
    puts "  Links: #{@links}"
    @links.select{|l| l.is_a? LayerLink}.collect{|l| l.layer}.uniq
  end
  
  # retrieves and returns all linked scales from the scale links
  def scales
    #@todo get array of scales from scale link objects
  end
  
  # retrieves and returns all linked events from the event links
  def events
    #@todo get hash (:role => event) from event links
  end
  
end