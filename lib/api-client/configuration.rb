module ApiClient
  # ApiClient::Configuration provides a way to configure ApiClient globally.
  class Configuration
    # Handle a boolean to define when mock the requisitions.
    #
    # @return [Boolean] boolean used to set mock requisitions.
    attr_accessor :mock

    # Handle a the hydra object used by typhoeus to make parallel requisitions.
    #
    # @return [Typhoeus] object that handle parallel requests.
    attr_accessor :hydra

    # The default header for all requisitions
    #
    # @return [Hash] all the default header params used by ApiClient.
    attr_reader :header

    # Return the api url.
    #
    # @return [String] the api url.
    def path
      @paths.each do |name, path|
        raise Exceptions::BadlyConfigured.new(name) unless path.size > 1
      end
      @paths
    end

    # Set the api url.
    #
    # @param [String] path api url.
    def path=(path)
      path = "#{path}/" unless path[path.size - 1, 1] == '/'
      @paths = { :default => path }
    end

    # Set several api urls.
    #
    # @param [Hash] paths hash with paths to api urls.
    def paths=(paths = {})
      @paths = {}
      paths.each do |name, path|
        if path[path.size - 1, 1] == '/'
          @paths[name] = path
        else
          @paths[name] = "#{path}/"
        end
      end
    end

    # Set the default params of header.
    #
    # @param [Hash] header the default header for requisitions.
    def header=(header = {})
      @header = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }.merge(header)
    end

    # Set a basic authentication for all requisitions.
    #
    # @param [String] account the user for requisitions.
    # @param [String] password the password for requisitions.
    def basic_auth(account, password)
      @header.merge!({ 'Authorization' => "Basic #{["#{account}:#{password}"].pack('m').delete("\r\n")}" })
    end
  end
end