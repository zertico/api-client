class ApiClient::Exceptions::Unauthorized < ApiClient::Exceptions::Generic
  def self.initialize
    super("Authentication Required!")
  end
end