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
  #     config.path = "api.example.com"
  #   end
  # @yield Yield the configuration object
  # @yieldparam block The Configuration object
  # @yieldreturn [ApiClient::Configuration] The Configuration object
  def self.configure(&block)
    yield @config ||= ApiClient::Configuration.new
  end

  # Global settings for ApiClient
  #
  # @return [Hash] configuration attributes
  def self.config
    @config
  end

  # Parallel api requisitions
  #
  # @yield The requisitions to be made
  # @yieldparam block A block with requisition objects
  # @return [False] the value of the hydra config
  def self.parallel(&block)
    raise Exceptions::NotPossible unless defined?(::Typhoeus)
    config.hydra = ::Typhoeus::Hydra.new
    yield
    config.hydra.run
    config.hydra = false
  end

  # Default Settings
  configure do |config|
    config.path = ''
    config.header = {}
    config.mock = false
    config.hydra = false
  end
end