class ApiClient::Exceptions::NotFound < ApiClient::Exceptions::Generic
  def initialize
    super("The required url could not be found!")
  end
end