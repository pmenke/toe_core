require 'rdf'

class ToE::Porter::RdfPorter
  
  def write(document)
    
  end
  
end

module ToE
  module Model
    
    class ToEDocument
      
      def as_rdf(arr)
        return [ [ RDF::URI.new(get_uri_for_rdf), "b", "c" ] ]
      end
      
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
        return "http://foo.bar/documents/1"
      end
      
    end
    
  end
end