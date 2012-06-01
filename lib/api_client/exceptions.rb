module ApiClient::Exceptions
  autoload :Generic, 'api_client/exceptions/generic'
  autoload :NotFound, 'api_client/exceptions/not_found'
  autoload :Unauthorized, 'api_client/exceptions/unauthorized'
  autoload :Forbidden, 'api_client/exceptions/forbidden'
  autoload :InternalServerError, 'api_client/exceptions/internal_server_error'
  autoload :BadGateway, 'api_client/exceptions/bad_gateway'
  autoload :ServiceUnavailable, 'api_client/exceptions/service_unavailable'
end