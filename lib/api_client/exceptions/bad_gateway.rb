class ApiClient::Exceptions::BadGateway < ApiClient::Exceptions::Generic
  def self.initialize
    super("Bad Gateway!")
  end
end