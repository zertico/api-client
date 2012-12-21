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
    # @param [String] api url.
    def path=(path)
      path = "#{path}/" unless path[path.size - 1, 1] == "/"
      @path = path
    end
  end
end
