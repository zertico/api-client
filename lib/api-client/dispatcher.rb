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
end
