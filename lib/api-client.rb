require "api-client/version"

# High Level Namespace of the library ApiClient.
module ApiClient
  autoload :Exceptions, 'api-client/exceptions'
  autoload :Base, 'api-client/base'
  autoload :Dispatcher, 'api-client/dispatcher'
  autoload :Parser, 'api-client/parser'
end