class InputError < StandardError
  attr_accessor :object

  def initialize(object)
    @object = object
  end
end
