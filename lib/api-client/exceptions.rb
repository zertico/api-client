# Namespace for the ApiClient Exceptions.
module ApiClient::Exceptions
  autoload :BadGateway, 'api-client/exceptions/bad_gateway'
  autoload :BadlyConfigured, 'api-client/exceptions/badly_configured'
  autoload :ConnectionRefused, 'api-client/exceptions/connection_refused'
  autoload :Forbidden, 'api-client/exceptions/forbidden'
  autoload :Generic, 'api-client/exceptions/generic'
  autoload :InternalServerError, 'api-client/exceptions/internal_server_error'
  autoload :NotFound, 'api-client/exceptions/not_found'
  autoload :NotPossible, 'api-client/exceptions/not_possible'
  autoload :ServiceUnavailable, 'api-client/exceptions/service_unavailable'
  autoload :Unauthorized, 'api-client/exceptions/unauthorized'
end