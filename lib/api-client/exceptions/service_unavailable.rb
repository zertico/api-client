# Exception for a Service Unavailable Response ( Status Code : 503 ).
# The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.
class ApiClient::Exceptions::ServiceUnavailable < ApiClient::Exceptions::Generic
  # Initialize a new exception.
  #
  # @return [ServiceUnavailable] a new exception.
  def self.initialize
    super('Service Unavailable!')
  end
end