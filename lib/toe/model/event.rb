module ToE
  
  module Model
    
    # The Event class is the central data element in a ToE document.
    # It links data chunks to specific points or intervals on one or
    # more scales.
    class Event < BasicToEObject
      
      # data object that can hold different object structures
      # @returns [Data] data object of this event
      attr_reader :data
      
      # up link to the event set
      # @returns [EventSet] event set container object of this event
      attr_reader :event_set
      
      # container for links
      # @returns [Array] data object of this event
      attr_reader :links
      
      
      public
      
      # create a new, empty and unlinked Event object.
      def initialize
        puts "Hello World"
        data=nil
        event_set=nil
        links=[]
      end
      
      # set a new data object for this event
      # @param [Data] the data object to set
      # @return [Boolean] true iff assignment worked
      def data=(new_data)
        @data = val
      end
      
      # set a new event set parent for this event
      def event_set=(new_event_set)
        @event_set = val
      end

      # replace the existing link array with new one
      def links(new_links)
        @links = val
      end
      
    end
  end
  
end