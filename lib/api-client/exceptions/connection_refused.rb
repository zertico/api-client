class ApiClient::Exceptions::ConnectionRefused < ApiClient::Exceptions::Generic
  def self.initialize
    super("Connection Refused!")
  end
end