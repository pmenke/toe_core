# This is a helper module for all parts of an event document. adds support for accessing the containing document.

module ToE::Model::BelongsToEventDocument

  # get the containing document.
  # @return [ToeDocument] the containing toe event document.
	def document
	  @document
	end
  
  # set the containing document
  # @param [ToeDocument] the new containing document.
  def document=(new_document)
    @document = new_document
  end

  # access to the document resolver.
  # @param [Object] the object to resolve in the porter
  # @return [Object] the found object, or nil if nothing was found.
  def resolve(object)
    document.porter.resolve(object)
  end
  
end