# ApiClient::Dispatcher provides methods to make requests
module ApiClient::Dispatcher
  autoload :Typhoeus, 'api-client/dispatcher/typhoeus'
  autoload :NetHttp, 'api-client/dispatcher/net-http'
  autoload :Parallel, 'api-client/dispatcher/parallel'

  def self.method_missing(method_name, *args)
    case true
      when ApiClient.config.hydra && defined?(::Typhoeus)
        return Parallel.send(method_name, *args) if Parallel.respond_to?(method_name)
      when defined?(::Typhoeus)
        return Typhoeus.send(method_name, *args) if Typhoeus.respond_to?(method_name)
      else
        return NetHttp.send(method_name, *args) if NetHttp.respond_to?(method_name)
    end
    super
  end

  # Overwrite respond_to? default behavior
  #
  # @param [Symbol] method_name the name of the method.
  # @param [Boolean] include_private if it does work to private methods as well.
  # @return [Boolean] if it responds to the method or not.
  def self.respond_to_missing?(method_name, include_private = false)
    case true
      when ApiClient.config.hydra && defined?(::Typhoeus)
        return true if Parallel.respond_to?(method_name)
      when defined?(::Typhoeus)
        return true if Typhoeus.respond_to?(method_name)
      else
        return true if NetHttp.respond_to?(method_name)
    end
    super
  end
end