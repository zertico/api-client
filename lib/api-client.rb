require "api-client/version"

# High Level Namespace of the library ApiClient.
module ApiClient
  autoload :Exceptions, 'api-client/exceptions'
  autoload :Errors, 'api-client/errors'
  autoload :Configuration, 'api-client/configuration'
  autoload :Base, 'api-client/base'
  autoload :Collection, 'api-client/collection'
  autoload :Dispatcher, 'api-client/dispatcher'
  autoload :Parser, 'api-client/parser'
  autoload :Builder, 'api-client/builder'

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

  configure do |config|
    config.path = ''
  end
end
