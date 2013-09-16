module ApiClient
  # This module handles the logic to make an api call and update_attributes the current object with the response.
  module InstanceMethods
    # Make a get requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def get(header = {})
      return self if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.get(url, header)
      update(response, url)
    end

    alias_method :reload, :get

    # Make a post requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def post(header = {})
      return self if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.class.resource_path}"
      response = ApiClient::Dispatcher.post(url, self.to_hash, header)
      update(response, url)
    end

    alias_method :create, :post

    # Make a put requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def put(header = {})
      return self if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.class.resource_path}"
      response = ApiClient::Dispatcher.put(url, self.to_hash, header)
      update(response, url)
    end

    alias_method :update_attributes, :put

    # Make a patch requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def patch(header = {})
      return self if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.class.resource_path}"
      response = ApiClient::Dispatcher.patch(url, self.to_hash, header)
      update(response, url)
    end

    # Make a delete requisition and update the object with the response.
    #
    # @param [Hash] header hash with the header options.
    # @return [Base] the object updated.
    def delete(header = {})
      return self if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.class.resource_path}/#{id}"
      response = ApiClient::Dispatcher.delete(url, header)
      update(response, url)
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

    protected

    # Update an object based on a hash of attributes.
    #
    # @param [Response] response requisition response.
    # @param [String] url the url of the requisition.
    # @return [Base] the update_attributes object.
    def update(response, url)
      return response if ApiClient.config.hydra
      attributes = ApiClient::Parser.response(response, url)
      hash = remove_root(attributes)
      hash = hash.merge({ 'response' => attributes })
      self.attributes = hash
      self
    end
  end
end