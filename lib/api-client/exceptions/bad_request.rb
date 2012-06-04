class ApiClient::Exceptions::BadRequest < ApiClient::Exceptions::Generic
  def self.initialize
    super("Bad Request!")
  end
end