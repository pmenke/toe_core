require 'rdf'
require 'rdf/ntriples'

class ToE::Porter::RdfPorter
  
  def write(document)
    
  end
  
end

module ToE
  module Model

    BASE_URI = "http://phoibos.sfb673.org/resources" # TODO correct?
    
    class ToEDocument

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end        

        # pass complex objects along
        # pass head along 
        @head.each do |head|
          
          puts "Export Head to RDF"
          triples << [get_uri_for_rdf, "head", head]
          triples = head.as_rdf(triples)
          
        end  

        # pass scaleSet along 
        @scale_set.each do |scaleSet|
          
          puts "Export ScaleSet to RDF"
          triples << [get_uri_for_rdf, "scaleSet", scaleSet]
          triples = scaleSet.as_rdf(triples)
          
        end

        # pass referenced_object_list along 
=begin        @referenced_object_list.each do |referencedObjectList|
          
          puts "Export ReferencedObjectList to RDF"
          triples << [get_uri_for_rdf, "referencedObjectList", referencedObjectList]
          triples = referencedObjectList.as_rdf(triples)
          
        end
=end
        # pass agent_list along 
=begin        @agent_list.each do |agentList|
          
          puts "Export AgentList to RDF"
          triples << [get_uri_for_rdf, "agentList", agentList]
          triples = agentList.as_rdf(triples)
          
        end
=end
        # pass layer_structure along 
        @layer_structure.each do |layerStructure|
          
          puts "Export LayerStructure to RDF"
          triples << [get_uri_for_rdf, "layerStructure", layerStructure]
          triples = layerStructure.as_rdf(triples)
          
        end

        # pass event_set along 
        @event_set.each do |eventSet|
          
          puts "Export EventSet to RDF"
          triples << [get_uri_for_rdf, "eventSet", eventSet]
          triples = eventSet.as_rdf(triples)
          
        end

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class Head

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   

        # pass complex objects along
        # pass features along 
        @features.each do |feature|
          
          puts "Export Feature to RDF"
          triples << [get_uri_for_rdf, "feature", feature]
          triples = feature.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

=begin    class ReferencedObjectList

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   

        # pass complex objects along
        # pass referenced_object along 
        @referenced_object.each do |referencedObject|
          
          puts "Export ReferencedObject to RDF"
          triples << [get_uri_for_rdf, "referencedObject", referencedObject]
          triples = referencedObject.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end
=end
    class ScaleSet

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # pass complex objects along
        # pass scales along 
        @scales.each do |scale|
          
          puts "Export Scale to RDF"
          triples << [get_uri_for_rdf, "scale", scale]
          triples = scale.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class LayerStructure

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # pass complex objects along
        # pass layers along 
        @layers.each do |layer|
          
          puts "Export Layer to RDF"
          triples << [get_uri_for_rdf, "layer", layer]
          triples = layer.as_rdf(triples)
          
        end  

        # pass connectors along 
        @connectors.each do |layerConnector|
          
          puts "Export LayerConnector to RDF"
          triples << [get_uri_for_rdf, "layerConnector", layerConnector]
          triples = layerConnector.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end 

=begin    class AgentList

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   	

        # pass complex objects along
        # pass agents along 
        @agents.each do |agent|
          
          puts "Export Agent to RDF"
          triples << [get_uri_for_rdf, "agent", agent]
          triples = agent.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end   
=end
    class EventSet

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # pass complex objects along
        # pass events along 
        @events.each do |event|
          
          puts "Export Event to RDF"
          triples << [get_uri_for_rdf, "event", event]
          triples = event.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class Feature

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end           	
	if key
		triples << [get_uri_for_rdf, "key", key]
	end   
        triples << [get_uri_for_rdf, "type", type]	
        triples << [get_uri_for_rdf, "featureValue", value]	

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

=begin    class ReferencedObject

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   
        triples << [get_uri_for_rdf, "absolute", absolute]	
        triples << [get_uri_for_rdf, "mimetype", mimetype]	
        triples << [get_uri_for_rdf, "objecttype", objecttype]	
        triples << [get_uri_for_rdf, "uri", uri]	

        # pass complex objects along
        # pass features along 
        @features.each do |feature|
          
          puts "Export Feature to RDF"
          triples << [get_uri_for_rdf, "feature", feature]
          triples = feature.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end
=end
    class Scale

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   
	if mode
		triples << [get_uri_for_rdf, "scaleMode", mode] # TODO only specific modes possible	
	end  
	if role
		triples << [get_uri_for_rdf, "scaleRole", role] 
	end
        if continuous
		triples << [get_uri_for_rdf, "continuous", continuous]	
	end   
	if dimension
		triples << [get_uri_for_rdf, "dimension", dimension]	
	end           
        
        triples << [get_uri_for_rdf, "unit", unit]	

        # pass complex objects along
        # pass elements along 
        @elements.each do |scaleElement|
          
          puts "Export ScaleElement to RDF"
          triples << [get_uri_for_rdf, "scaleElement", scaleElement]
          triples = scaleElement.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class ScaleElement

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   
	if value
		triples << [get_uri_for_rdf, "scaleValue", value]	
	end           	

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class Layer

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   
	if dataType
		triples << [get_uri_for_rdf, "dataType", dataType]
	end  
	if contentStructure
		triples << [get_uri_for_rdf, "contentStructure", contentStructure] # TODO only specific structures possible	
	end        

        # pass complex objects along
        # pass features along 
        @features.each do |feature|
          
          puts "Export Feature to RDF"
          triples << [get_uri_for_rdf, "feature", feature]
          triples = feature.as_rdf(triples)
          
        end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end   

    class LayerConnector

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   
	if role
		triples << [get_uri_for_rdf, "layerRole", role]
	end  
	if order
		triples << [get_uri_for_rdf, "order", order]	
	end  
	if source
		triples << [get_uri_for_rdf, "source", source]		
	end  
	if target
		triples << [get_uri_for_rdf, "target", target]
	end  
	if cardinality
		triples << [get_uri_for_rdf, "cardinality", cardinality] # TODO only specific cardinatlities possible	
	end  

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

=begin    class Agent

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   
        triples << [get_uri_for_rdf, "number", number]	
        triples << [get_uri_for_rdf, "agentRole", role]

        # pass complex objects along
        # pass features along 
        @features.each do |feature|
          
          puts "Export Feature to RDF"
          triples << [get_uri_for_rdf, "feature", feature]
          triples = feature.as_rdf(triples)
          
        end 

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end   
=end
    class Event

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   

        # pass complex objects along
        # pass data along 
        @data.each do |data|
          
          puts "Export Data to RDF"
          triples << [get_uri_for_rdf, "data", data]
          triples = data.as_rdf(triples)
          
        end 

        # pass links along
        @links.each do |link|
          
          puts "Export Link to RDF"
          triples << [get_uri_for_rdf, "link", link]
          triples = link.as_rdf(triples)
          
        end 

        # pass notes along
=begin        @notes.each do |noteList|
          
          puts "Export NoteList to RDF"
          triples << [get_uri_for_rdf, "noteList", noteList]
          triples = noteList.as_rdf(triples)
          
        end 
=end
	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class Data

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
	if id
		triples << [get_uri_for_rdf, "hasId", id]
	end           
        triples << [get_uri_for_rdf, "dataValue", value]

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class Link

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
	if name
		triples << [get_uri_for_rdf, "hasName", name]	
	end   	
	if order
		triples << [get_uri_for_rdf, "order", order]
	end   
	if target
		triples << [get_uri_for_rdf, "target", target]		
	end   
	if roleType
		triples << [get_uri_for_rdf, "roleType", roleType] # TODO only specific roles possible
	end   
       
	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end

    class LayerLink < Link

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

	# TODO strange, no new attributes

	return triples
      end
      
    end

    class TPointLink < Link

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)   # TODO not sure how to extend and not overwrite method of super class

	if element
		triples << [get_uri_for_rdf, "element", element] # TODO only specific Subrefs allowed	
	end   
	if elementType
		triples << [get_uri_for_rdf, "elementType", elementType] # TODO only specific TargetItemTypes allowed	
	end   

	return triples
      end
      
    end

    class IntervalLink < Link

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        triples << [get_uri_for_rdf, "max", max] # TODO only specific Subrefs allowed
	if maxInclusive
		triples << [get_uri_for_rdf, "maxInclusive", maxInclusive]
	end  
	if maxType
		triples << [get_uri_for_rdf, "maxType", maxType] # TODO only specific TargetItemTypes allowed	
	end  
        triples << [get_uri_for_rdf, "min", min] # TODO only specific Subrefs allowed
	if minInclusive
		triples << [get_uri_for_rdf, "minInclusive", minInclusive]	
	end  
	if minType
		triples << [get_uri_for_rdf, "minType", minType] # TODO only specific TargetItemTypes allowed	
	end  

	return triples
      end
      
    end

    class EventLink < Link

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

	# TODO strange, no new attributes

	return triples
      end
      
    end

=begin    class NoteList

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]

        # pass notes along
        @notes.each do |note|
          
          puts "Export Note to RDF"
          triples << [get_uri_for_rdf, "note", note]
          triples = note.as_rdf(triples)
          
        end 

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end
=end
=begin    class Note

      # Adds raw RDF information to a plain array of triples
      # and returns it.
      # @return Array of triple arrays      
      def as_rdf(arr)

        # convert objects to rdf
        triples << [get_uri_for_rdf, "hasId", id]
        triples << [get_uri_for_rdf, "author", author]
        triples << [get_uri_for_rdf, "timestamp", timestamp]

	return triples
        #return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
      # Creates an RDF object from the ruby object structure by calling as_rdf
      # on the top object and converting it to an RDF::Graph
      # @return RDF::Graph
      def to_rdf()
        graph = RDF::Graph.new
        as_rdf(Array.new).each do |triple|
          puts triple 
          graph << triple
        end
        return graph
      end
      
      # Returns a string containing RDF in ntriples format.
      # You can print this string to check whether any errors occurred.
      # @return String
      def to_ntriples()
        buffer = RDF::Writer.for(:ntriples).buffer do |writer|
          writer << to_rdf
        end
        return buffer
      end
      
      def get_uri_for_rdf
        # todo integrate URI base given by surrounding library
        # return "http://foo.bar/documents/1"
        return "#{::Mucomo::Interfaces::RDF::BASE_URI}/toe/#{self.id}"
      end
      
    end
=end
  end
end
