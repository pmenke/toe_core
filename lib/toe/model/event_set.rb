# To change this template, choose Tools | Templates
# and open the template in the editor.

class ToE::Model::EventSet < ToE::Model::BasicToEObject
  def initialize
    
    @events = Array.new
    @by_id = Hash.new
    @by_layer = Hash.new
    @by_scale = Hash.new
    
  end
  
  # adds an event to the containers
  def add(event)
    unless @events.include? event
      @events << event
      event.event_set = self
      @by_id[event.id] = event
      #event.layers.each do |layer|
      event.layers.each do |l|
        puts "Cache a link to Layer #{l.id}"
        @by_layer[l] = [] unless @by_layer.has_key?(l)
        @by_layer[l] << event
      end
      #end
    end
  end
  
  def events
    @events
  end
  
  # returns the event with the given id.
  def find_by_id(id)
    @by_id[id]
  end
  
  def find_by_layer(layer)
    puts "EventSet: get events for a layer"
    puts @by_layer.size
    puts @by_layer[layer].size
    return @by_layer[layer]
  end
  
  #@return [Integer or nil] the number of events in this event set
  def size
    return @events.size
  end
  
end
