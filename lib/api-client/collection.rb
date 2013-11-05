# ApiClient::Collection handle a collection of objects
class ApiClient::Collection < Array
  # Initialize a collection of objects based on attributes.
  #
  # @param [String] attributes the array of attributes.
  # @param [Class] klass The class to instantiate the objects.
  # @return [Collection] the collection of objects.
  def initialize(attributes, klass)
    @klass = klass
    @response = attributes
    if attributes.instance_of?(Array)
      attributes.each do |attr|
        self << @klass.new(attr)
      end
    elsif attributes[klass.name.pluralize.downcase].instance_of?(Array)
      attributes = pagination_attributes(attributes)
      attributes[klass.name.pluralize.downcase].each do |attr|
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
    elsif attributes[@klass.name.pluralize.downcase].instance_of?(Array)
      attributes[@klass.name.pluralize.downcase].each do |attr|
        self << @klass.new(attr)
      end
    else
      self << @klass.new(attributes)
    end
  end

  def pagination_attributes(attributes)
    @total = attributes.delete("total")
    @total_pages = attributes.delete("total_pages")
    @offset = attributes.delete("offset")
    @_links = attributes.delete("_links")
    attributes
  end
end