# All other exceptions should extend this one. This exception was made to
# be easy to handle all possible errors on api requests with just one line:
#  rescue_from ApiClient::Exceptions::Generic, :with => :generic_error
class ApiClient::Exceptions::Generic < StandardError
end