# ApiClient::Collection handle a collection of objects
class ApiClient::Collection
  include Enumerable

  attr_accessor :collection

  # Initialize a collection of given objects
  #
  # @param [Class] The class to instantiate the objects.
  # @param [String] The url to get the data.
  # @return [Collection] the collection of objects.
  def initialize(klass, url)
    @collection = ApiClient::Parser.response(ApiClient::Dispatcher.get(url), url)
    @collection.map! do |attributes|
      klass.new(attributes)
    end
  end
end