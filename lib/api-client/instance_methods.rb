module ApiClient
  # This module handles the logic to make an api call and update the current object with the response.
  module InstanceMethods
    # Update an object based on a hash of attributes.
    #
    # @param [Hash] params hash of attributes.
    # @return [Base] the updated object.
    def update(params)
      if params.key?(self.class.remote_object)
        params[self.class.remote_object].each do |key, value|
          instance_variable_set(key.to_sym, value)
        end
        instance_variable_set(response.to_sym, params[self.class.remote_object])
      else
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        instance_variable_set("@response", params)
      end
      self
    end

    # Make the api call and pass the parsed response to update the current object.
    #
    # @param [Symbol] method_name the name of the method.
    # @param [Integer] id the id of the current object.
    # @param [Array] args an array of params.
    # @return [Base] the object updated.
    def method_missing(method_name, id = nil, *args)
      url = "#{ApiClient.config.path}#{self.class.path}"
      "#{url}/#{id}" unless id.nil?
      response = ApiClient::Dispatcher.send(method_name.to_sym, url, *args)
      params = ApiClient::Parser.response(response, url)
      update(params)
    end

    # Overwrite respond_to? default behavior
    #
    # @param [Symbol] method_name the name of the method.
    # @param [Boolean] include_private if it does work to private methods as well.
    # @return [Boolean] if it responds to the method or not.
    def respond_to_missing?(method_name, include_private = false)
      return true if ApiClient::Dispatcher.respond_to?(method_name)
      super
    end
  end
end