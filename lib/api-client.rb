require "api-client/version"

module ApiClient
  autoload :Exceptions, 'api-client/exceptions'
  autoload :Base, 'api-client/base'
  autoload :Dispatcher, 'api-client/dispatcher'
  autoload :Parser, 'api-client/parser'
end