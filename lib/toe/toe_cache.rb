require 'singleton'
	class ToE::ToECache
	  include Singleton
	  
	  def initialize
	    super
	    
	    @documents = []
	    @events = []
	    
	    @step = 0
	    
    end
	  
	  def cached?(toe_document)
	    #@todo return true if this document is in the cache already
    end
    
    def add_document(toe_document)
      
    end
    
    # finds events according to given properties
    #
    # :value  :: String, Regexp, Hash
    # 
    def find(params={})
      
    end
    
    def step
      @step = @step + 1
      @step
    end
    
	end