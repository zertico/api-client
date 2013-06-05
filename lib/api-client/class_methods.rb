module ApiClient
  # This module handles the logic to make an api call and initialize an object with the response.
  module ClassMethods
    # Initialize an object based on a hash of attributes.
    #
    # @param [Hash] attributes hash of attributes.
    # @return [Base] the object initialized.
    def build(params)
      if params.key?(remote_object)
        new(params[remote_object].merge(:response => params))
      else
        new(params.merge(:response => params))
      end
    end

    # Make the api call and pass the parsed response to build to create a new object.
    #
    # @param [Symbol] method_name the name of the method.
    # @param [Integer] id the id of the object.
    # @param [Array] args an array of params.
    # @return [Base] the object initialized.
    def method_missing(method_name, id = nil, *args)
      url = "#{ApiClient.config.path}#{self.path}"
      "#{url}/#{id}" unless id.nil?
      response = ApiClient::Dispatcher.send(method_name.to_sym, url, *args)
      params = ApiClient::Parser.response(response, url)
      build(params)
    end
  end
end