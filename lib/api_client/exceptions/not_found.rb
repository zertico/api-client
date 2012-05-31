class ApiClient::Exceptions::NotFound < ApiClient::Exceptions::Generic
  def self.initialize
    super("The required url could not be found!")
  end
end