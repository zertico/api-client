module ApiClient
  # ApiClient::Configuration provides a way to configure ApiClient globally.
  class Configuration
    attr_accessor :mock
    attr_reader :header

    # Return the api url.
    #
    # @return [String] the api url.
    def path
      raise Exceptions::NotConfigured unless @path.size > 1
      @path
    end

    # Set the api url.
    #
    # @param [String] path api url.
    def path=(path)
      path = "#{path}/" unless path[path.size - 1, 1] == '/'
      @path = path
    end

    # Set the default params of header.
    #
    # @param [Hash] header the default header for requisitions.
    def header=(header = {})
      @header = { 'Content-Type' => 'application/json' }.merge(header)
    end

    # Set a basic authentication for all requisitions.
    #
    # @param [Hash] header the default header for requisitions.
    def basic_auth(account, password)
      @header.merge!({ 'Authorization' => "Basic #{["#{account}:#{password}"].pack('m').delete("\r\n")}" })
    end
  end
end