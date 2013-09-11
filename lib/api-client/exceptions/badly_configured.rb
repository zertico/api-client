# Exception for requests where the full path is not properly configured.
class ApiClient::Exceptions::BadlyConfigured < StandardError
  # Initialize a new exception.
  #
  # @return [NotConfigured] a new exception.
  def self.initialize(name)
    super("The api path #{name} is not properly configured!")
  end
end