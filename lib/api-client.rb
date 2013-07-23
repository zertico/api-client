require 'api-client/version'

# High Level Namespace of the library ApiClient.
module ApiClient
  autoload :Exceptions, 'api-client/exceptions'
  autoload :Errors, 'api-client/errors'
  autoload :Configuration, 'api-client/configuration'
  autoload :Base, 'api-client/base'
  autoload :Collection, 'api-client/collection'
  autoload :ClassMethods, 'api-client/class_methods'
  autoload :InstanceMethods, 'api-client/instance_methods'
  autoload :Dispatcher, 'api-client/dispatcher'
  autoload :Parser, 'api-client/parser'

  # Configures global settings
  #   ApiClient.configure do |config|
  #     config.url_path = "api.example.com"
  #   end
  def self.configure(&block)
    yield @config ||= ApiClient::Configuration.new
  end

  # Global settings for ApiClient
  def self.config
    @config
  end

  # Default Settings
  configure do |config|
    config.path = ''
    config.header = {}
  end
end