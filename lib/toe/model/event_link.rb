# A link pointing to another event. The role (and, optionally, order) attribute should be given.

class ToE::Model::EventLink < ToE::Model::Link
  
  # FIXME Doc me!
  def initialize
    super
  end
  
  # FIXME Doc me!
  def event
    target
  end
  
end
