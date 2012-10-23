# Exception for a Not Found Response ( Status Code : 404 ).
# The server has not found anything matching the Request-URI.
class ApiClient::Exceptions::NotFound < ApiClient::Exceptions::Generic
  # Initialize a new exception.
  #
  # @return [NotFound] a new exception.
  def self.initialize(url)
    super("The requested url (#{url}) could not be found!")
  end
end