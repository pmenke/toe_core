module ToE::Model::BelongsToEventDocument

	def document
	  @document
	end
  
  def document=(new_document)
    @document = new_document
  end

  def resolve(object)
    document.porter.resolve(object)
  end
  
end