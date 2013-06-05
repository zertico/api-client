# Exception for a Connection Refused Response.
class ApiClient::Exceptions::ConnectionRefused < ApiClient::Exceptions::Generic
  # Initialize a new exception.
  #
  # @return [ConnectionRefused] a new exception.
  def self.initialize
    super('Connection Refused!')
  end
end