class ApiClient::Exceptions::NotFound < StandardError
  def initialize
    super("The required url could not be found!")
  end
end