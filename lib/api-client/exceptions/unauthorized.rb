# Exception for a Unauthorized Response ( Status Code : 401 ).
# The request requires user authentication.
class ApiClient::Exceptions::Unauthorized < ApiClient::Exceptions::Generic
  # Initialize a new exception.
  #
  # @return [Unauthorized] a new exception.
  def self.initialize
    super("Authentication Required!")
  end
end