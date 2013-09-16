require 'net/http'
require 'api-client/net/http' unless Net::HTTP.new('').respond_to?(:patch)

# ApiClient::Dispatcher::NetHttp provides methods to make requests using the native ruby library 'net/http'
module ApiClient::Dispatcher::NetHttp
  # Make a get request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.get(url, header = {})
    dispatch(:get, url, { :header => header })
  end

  # Make a post request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.post(url, args, header = {})
    dispatch(:post, url, { :args => args, :header => header })
  end

  # Make a put request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.put(url, args, header = {})
    dispatch(:put, url, { :args => args, :header => header })
  end

  # Make a patch request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.patch(url, args, header = {})
    dispatch(:patch, url, { :args => args, :header => header })
  end

  # Make a delete request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def self.delete(url, header = {})
    dispatch(:delete, url, { :header => header })
  end

  protected

  def self.dispatch(method, url, options = {})
    args = options[:args].to_json if options[:args]
    header = ApiClient.config.header.merge(options[:header])
    uri = URI(url)
    http = Net::HTTP.start(uri.host, uri.port)
    begin
      if args
        http.send(method, uri.request_uri, args, header)
      else
        http.send(method, uri.request_uri, header)
      end
    rescue Errno::ECONNREFUSED
      raise ApiClient::Exceptions::ConnectionRefused
    end
  end
end