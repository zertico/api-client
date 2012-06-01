class ApiClient::Exceptions::InternalServerError < ApiClient::Exceptions::Generic
  def self.initialize
    super("Internal Server Errorr!")
  end
end