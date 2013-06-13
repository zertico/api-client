module ApiClient
  # ApiClient::Configuration provides a way to configure ApiClient globally.
  class Configuration
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

    # Return the default header for requisitions.
    #
    # @return [Hash] the default header.
    def header
      return { 'Content-Type' => 'application/json' } unless @header
      @header
    end

    # Set the default header for requisitions.
    #
    # @param [Hash] header the default header for requitions.
    def header=(header = {})
      @header = { 'Content-Type' => 'application/json' }.merge(header)
    end
  end
end