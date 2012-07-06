require "net/http"

# ApiClient::Dispatcher provides methods to make requests using the native ruby library 'net/http'
module ApiClient::Dispatcher
  # Make a get request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def _get(url, header)
    initialize_connection(url)
    @http.get(@uri.path, header)
  end

  # Make a post request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def _post(url, args, header)
    initialize_connection(url)
    @http.post(@uri.path, args.to_json, { 'Content-Type' => 'application/json' }.merge(header))
  end

  # Make a put request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def _put(url, args, header)
    initialize_connection(url)
    @http.put(@uri.path, args.to_json, { 'Content-Type' => 'application/json' }.merge(header))
  end

  # Make a patch request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def _patch(url, args, header)
    initialize_connection(url)
    @http.patch(@uri.path, args.to_json, { 'Content-Type' => 'application/json' }.merge(header))
  end

  # Make a delete request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [HTTP] the response object.
  def _delete(url, header)
    initialize_connection(url)
    @http.delete(@uri.path, header)
  end

  protected

  def initialize_connection(url = '')
    @uri = URI(url)
    @http = Net::HTTP.new(@uri.host, @uri.port)
  end
end