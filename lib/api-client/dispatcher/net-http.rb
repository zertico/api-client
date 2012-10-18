require "net/http"
require "api-client/net/http" unless Net::HTTP.new("").respond_to?(:patch)

# ApiClient::Dispatcher provides methods to make requests using the native ruby library 'net/http'
module ApiClient::Dispatcher::NetHttp
  # Make a get request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.get(url, header = {})
    initialize_connection(url)
    call { @http.get(@uri.request_uri, { 'Content-Type' => 'application/json' }.merge(header)) }
  end

  # Make a post request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.post(url, args, header = {})
    initialize_connection(url)
    call { @http.post(@uri.request_uri, args.to_json, { 'Content-Type' => 'application/json' }.merge(header)) }
  end

  # Make a put request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.put(url, args, header = {})
    initialize_connection(url)
    call { @http.put(@uri.request_uri, args.to_json, { 'Content-Type' => 'application/json' }.merge(header)) }
  end

  # Make a patch request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.patch(url, args, header = {})
    initialize_connection(url)
    call { @http.patch(@uri.request_uri, args.to_json, { 'Content-Type' => 'application/json' }.merge(header)) }
  end

  # Make a delete request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.delete(url, header = {})
    initialize_connection(url)
    call { @http.delete(@uri.request_uri, header) }
  end

  protected

  def self.initialize_connection(url = '')
    @uri = URI(url)
    @http = Net::HTTP.start(@uri.host, @uri.port)
  end

  def self.call
    begin
      yield
    rescue Errno::ECONNREFUSED
      raise ApiClient::Exceptions::ConnectionRefused
    end
  end
end
