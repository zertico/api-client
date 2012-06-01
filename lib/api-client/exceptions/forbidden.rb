class ApiClient::Exceptions::Forbidden < ApiClient::Exceptions::Generic
  def self.initialize
    super("Forbidden!")
  end
end