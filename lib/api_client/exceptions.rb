module ApiClient::Exceptions
  autoload :Generic, 'api_client/exceptions/generic'
  autoload :NotFound, 'api_client/exceptions/not_found'
  autoload :Unauthorized, 'api_client/exceptions/unauthorized'
  autoload :Forbidden, 'api_client/exceptions/forbidden'
end