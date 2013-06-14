module ApiClient
  # This module handles the logic to make an api call and update_attributes the current object with the response.
  module InstanceMethods
    # Update an object based on a hash of attributes.
    #
    # @param [Hash] params hash of attributes.
    # @return [Base] the update_attributes object.
    def update_attributes(attributes)
      hash = remove_root(attributes)
      hash = hash.merge({ 'response' => attributes })
      hash.each do |key, value|
        send("#{key}=", value)
      end
      self
    end

    def get(header = {})
      url = "#{ApiClient.config.path}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.get(url, header)
      attributes = ApiClient::Parser.response(response, url)
      update_attributes(attributes)
    end

    def post(header = {})
      url = "#{ApiClient.config.path}#{self.class.resource_path}"
      response = ApiClient::Dispatcher.post(url, self.to_hash, header)
      attributes = ApiClient::Parser.response(response, url)
      update_attributes(attributes)
    end

    def put(header = {})
      url = "#{ApiClient.config.path}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.put(url, self.to_hash, header)
      attributes = ApiClient::Parser.response(response, url)
      update_attributes(attributes)
    end

    def patch(header = {})
      url = "#{ApiClient.config.path}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.post(url, self.to_hash, header)
      attributes = ApiClient::Parser.response(response, url)
      update_attributes(attributes)
    end

    def delete(header = {})
      url = "#{ApiClient.config.path}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.post(url, header)
      attributes = ApiClient::Parser.response(response, url)
      update_attributes(attributes)
    end

    def remove_root(attributes = {})
      attributes = attributes[self.class.root_node.to_sym] if attributes.key?(self.class.root_node.to_sym)
      attributes = attributes[self.class.root_node.to_s] if attributes.key?(self.class.root_node.to_s)
      attributes
    end
  end
end