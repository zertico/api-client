# Exception raised when one of the configured apis endpoints path is nil. This exception make sure the apis are properly configured.
class ApiClient::Exceptions::BadlyConfigured < StandardError
  # Initialize a new exception.
  #
  # @return [NotConfigured] a new exception.
  def self.initialize(name)
    super("The api path #{name} is not properly configured!")
  end
end