class ToE::Model::EventLink < ToE::Model::Link
  
  def initialize
    super
  end
  
  def event
    target
  end
  
end
