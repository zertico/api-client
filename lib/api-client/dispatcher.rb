# ApiClient::Dispatcher provides methods to make requests
module ApiClient::Dispatcher
  autoload :Typhoeus, 'api-client/dispatcher/typhoeus'
  autoload :NetHttp, 'api-client/dispatcher/net-http'

  def self.method_missing(method, *args)
    if defined?(::Typhoeus)
      Typhoeus.send(method, *args)
    else
      NetHttp.send(method, *args)
    end
  end

  # Overwrite respond_to? default behavior
  #
  # @param [Symbol] method_name the name of the method.
  # @param [Boolean] include_private if it does work to private methods as well.
  # @return [Boolean] if it responds to the method or not.
  def respond_to_missing?(method_name, include_private = false)
    return true if Typhoeus.respond_to?(method_name)
    return true if NetHttp.respond_to?(method_name)
    super
  end
end