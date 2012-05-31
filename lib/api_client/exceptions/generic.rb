class ApiClient::Exceptions::Generic < StandardError
  def initialize
    super("An Error Occurred!")
  end
end