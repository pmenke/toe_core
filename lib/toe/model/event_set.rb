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
  
  #@return [Integer or nil] the number of events in this event set
  def size
    return @events.size
  end
  
end
