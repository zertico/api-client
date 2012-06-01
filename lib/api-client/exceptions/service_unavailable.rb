class ApiClient::Exceptions::ServiceUnavailable < ApiClient::Exceptions::Generic
  def self.initialize
    super("Service Unavailable!")
  end
end