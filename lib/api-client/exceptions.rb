module ApiClient::Exceptions
  autoload :Generic, 'api-client/exceptions/generic'
  autoload :NotFound, 'api-client/exceptions/not_found'
  autoload :Unauthorized, 'api-client/exceptions/unauthorized'
  autoload :Forbidden, 'api-client/exceptions/forbidden'
  autoload :InternalServerError, 'api-client/exceptions/internal_server_error'
  autoload :BadGateway, 'api-client/exceptions/bad_gateway'
  autoload :ServiceUnavailable, 'api-client/exceptions/service_unavailable'
  autoload :ConnectionRefused, 'api-client/exceptions/connection_refused'
end