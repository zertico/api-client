# Exception for requests where the full path is not properly configured.
class ApiClient::Exceptions::NotConfigured < StandardError
  # Initialize a new exception.
  #
  # @return [NotConfigured] a new exception.
  def self.initialize
    super("The api path is not properly configured!")
  end
end
