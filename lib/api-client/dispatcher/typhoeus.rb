require 'typhoeus'

# ApiClient::Dispatcher provides methods to make requests using typhoeus
module ApiClient::Dispatcher::Typhoeus
  # Make a get request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.get(url, header = {})
    ::Typhoeus::Request.get(url, :headers => header)
  end

  # Make a post request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.post(url, args, header = {})
    ::Typhoeus::Request.post(url, :params => args, :headers => header)
  end

  # Make a put request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.put(url, args, header = {})
    ::Typhoeus::Request.put(url, :params => args, :headers => header)
  end

  # Make a patch request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.patch(url, args, header = {})
    ::Typhoeus::Request.patch(url, :params => args, :headers => header)
  end

  # Make a delete request and returns it.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [Typhoeus::Request] the response object.
  def self.delete(url, header = {})
    ::Typhoeus::Request.delete(url, :headers => header)
  end
end