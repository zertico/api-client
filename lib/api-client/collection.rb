# ApiClient::Collection handle a collection of objects
class ApiClient::Collection < Array
  # Initialize a collection of objects based on attributes.
  #
  # @param [String] attributes the array of attributes.
  # @param [Class] klass The class to instantiate the objects.
  # @return [Collection] the collection of objects.
  def initialize(attributes, klass)
    @klass = klass
    if attributes.instance_of?(Array)
      attributes.each do |attr|
        self << @klass.new(attr)
      end
    else
      self << @klass.new(attributes)
    end
  end

  # Update the collection of objects based on the new attributes.
  #
  # @param [String] attributes the array of attributes.
  # @return [Collection] the collection of objects.
  def update(attributes)
    self.clear
    if attributes.instance_of?(Array)
      attributes.each do |attr|
        self << @klass.new(attr)
      end
    else
      self << @klass.new(attributes)
    end
  end
end