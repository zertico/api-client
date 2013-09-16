# ApiClient::Dispatcher provides methods to make requests using typhoeus
class ApiClient::Dispatcher::Parallel
  def initialize(requisition)
    @requisition = requisition
  end

  def on_complete_update(variable)
    @requisition.on_complete do |response|
      attributes = ApiClient::Parser.response(response, response.effective_url)
      if variable.instance_of?(ApiClient::Colletion)
        variable.update(attributes)
      else
        variable.attributes = attributes
      end
    end
    ApiClient.config.hydra.queue @requisition
  end

  # Make a get request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.get(url, header = {})
    new(::Typhoeus::Request.new(url, :headers => ApiClient.config.header.merge(header)))
  end

  # Make a post request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.post(url, args, header = {})
    new(::Typhoeus.Request.new(url, :method => :post, :body => args, :headers => ApiClient.config.header.merge(header)))
  end

  # Make a put request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.put(url, args, header = {})
    new(::Typhoeus.Request.new(url, :method => :put, :body => args, :headers => ApiClient.config.header.merge(header)))
  end

  # Make a patch request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.patch(url, args, header = {})
    new(::Typhoeus.Request.new(url, :method => :patch, :body => args, :headers => ApiClient.config.header.merge(header)))
  end

  # Make a delete request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.delete(url, header = {})
    new(::Typhoeus.Request.new(url, :method => :delete, :headers => ApiClient.config.header.merge(header)))
  end
end