# Exception for a Bad Gateway Response ( Status Code : 502 ).
# The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.
class ApiClient::Exceptions::BadGateway < ApiClient::Exceptions::Generic
  # Initialize a new exception.
  #
  # @return [BadGateway] a new exception.
  def self.initialize
    super('Bad Gateway!')
  end
end