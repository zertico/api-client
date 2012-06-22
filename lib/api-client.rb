require "api-client/version"
require "net/http"
require "active_model"

module ApiClient
  autoload :Exceptions, 'api-client/exceptions'
  autoload :Base, 'api-client/base'
end