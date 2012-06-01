class ApiClient::Exceptions::Generic < StandardError
  def self.initialize
    super("An Error Occurred!")
  end
end