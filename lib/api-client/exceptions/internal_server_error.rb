# Exception for a Internal Server Error Response ( Status Code : 500 ).
# The server encountered an unexpected condition which prevented it from fulfilling the request.
class ApiClient::Exceptions::InternalServerError < ApiClient::Exceptions::Generic
  # Initialize a new exception.
  #
  # @return [InternalServerError] a new exception.
  def self.initialize
    super("Internal Server Errorr!")
  end
end