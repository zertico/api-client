module ApiClient
  # This module handles the logic to make an api call and update_attributes the current object with the response.
  module InstanceMethods
    # Update an object based on a hash of attributes.
    #
    # @param [Hash] attributes hash of attributes.
    # @return [Base] the update_attributes object.
    def update(attributes)
      hash = remove_root(attributes)
      hash = hash.merge({ 'response' => attributes })
      hash.each do |key, value|
        send("#{key}=", value)
      end
      self
    end

    # Make a get requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def get(header = {})
      return update({}) if ApiClient.config.mock
      url = "#{ApiClient.config.path}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.get(url, header)
      attributes = ApiClient::Parser.response(response, url)
      update(attributes)
    end

    alias_method :reload, :get

    # Make a post requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def post(header = {})
      return update({}) if ApiClient.config.mock
      url = "#{ApiClient.config.path}#{self.class.resource_path}"
      response = ApiClient::Dispatcher.post(url, self.to_hash, header)
      attributes = ApiClient::Parser.response(response, url)
      update(attributes)
    end

    alias_method :create, :post

    # Make a put requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def put(header = {})
      return update({}) if ApiClient.config.mock
      url = "#{ApiClient.config.path}#{self.class.resource_path}"
      response = ApiClient::Dispatcher.put(url, self.to_hash, header)
      attributes = ApiClient::Parser.response(response, url)
      update(attributes)
    end

    alias_method :update_attributes, :put

    # Make a patch requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def patch(header = {})
      return update({}) if ApiClient.config.mock
      url = "#{ApiClient.config.path}#{self.class.resource_path}"
      response = ApiClient::Dispatcher.patch(url, self.to_hash, header)
      attributes = ApiClient::Parser.response(response, url)
      update(attributes)
    end

    # Make a delete requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def delete(header = {})
      return update({}) if ApiClient.config.mock
      url = "#{ApiClient.config.path}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.delete(url, header)
      attributes = ApiClient::Parser.response(response, url)
      update(attributes)
    end

    alias_method :destroy, :delete

    # Removes the root node attribute if found.
    #
    # @param [Hash] attributes the hash with attributes.
    # @return [Hash] the hash with attributes without the root node.
    def remove_root(attributes = {})
      attributes = attributes[self.class.root_node.to_sym] if attributes.key?(self.class.root_node.to_sym)
      attributes = attributes[self.class.root_node.to_s] if attributes.key?(self.class.root_node.to_s)
      attributes
    end
  end
end