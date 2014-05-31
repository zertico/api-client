# ApiClient::Collection handle a collection of objects
class ApiClient::Collection < Array
  # Initialize a object to handle collections. It save the class associated to make possible to use parallel later.
  #
  # @param [Hash/Array] the hash or array of attributes.
  # @param [Class] klass The class to instantiate the objects.
  # @return [Collection] the collection of objects.
  def initialize(attributes, klass)
    @klass = klass
    update(attributes)
  end

  # Update the current collection with a new one. This method is used when initializing the collection for the first time
  # and when making a parallel request.
  #
  # @param [Hash/Array] the hash or array of attributes.
  # @return [Collection] the collection of objects.
  def update(attributes)
    self.clear
    @response = attributes
    if attributes.instance_of?(Array)
      attributes.each do |attr|
        self << @klass.new(attr)
      end
    elsif attributes[@klass.name.pluralize.downcase].instance_of?(Array)
      attributes = pagination_attributes(attributes)
      attributes[@klass.name.pluralize.downcase].each do |attr|
        self << @klass.new(attr)
      end
    else
      self << @klass.new(attributes)
    end
  end

  # Initialize variables to work with api pagination *(hal+json)*. It saves all related hal data for later usage.
  #
  # @param [Hash] the hash of attributes.
  # @return [Hash] the hash of attributes without pagination attributes.
  def pagination_attributes(attributes)
    @total = attributes.delete("total")
    @total_pages = attributes.delete("total_pages")
    @offset = attributes.delete("offset")
    @_links = attributes.delete("_links")
    attributes
  end
end