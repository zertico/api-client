module ApiClient
  # This module handles the logic to make an api call and initialize an object with the response.
  module ClassMethods
    # Make a get requisition and initialize an object with the response.
    #
    # @param [Integer] id id of the object.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def get(id, header = {})
      return new(:id => id) if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.get(url, header)
      build(response, url)
    end

    alias_method :find, :get

    # Make a post requisition and initialize an object with the response.
    #
    # @param [Hash] attributes hash with the attributes to send.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def post(attributes, header = {})
      return new(attributes) if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.resource_path}"
      response = ApiClient::Dispatcher.post(url, { self.root_node.to_sym => attributes }, header)
      build(response, url)
    end

    alias_method :create, :post

    # Make a put requisition and initialize an object with the response.
    #
    # @param [Hash] attributes hash with the attributes to send.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def put(id, attributes, header = {})
      return new(attributes) if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.put(url, { self.root_node.to_sym => attributes }, header)
      build(response, url)
    end

    alias_method :update_attributes, :put

    # Make a patch requisition and initialize an object with the response.
    #
    # @param [Hash] attributes hash with the attributes to send.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def patch(id, attributes, header = {})
      return new(attributes) if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.patch(url, { self.root_node.to_sym => attributes }, header)
      build(response, url)
    end

    # Make a delete requisition and initialize an object with the response.
    #
    # @param [Integer] id id of the object.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def delete(id, header = {})
      return new(:id => id) if ApiClient.config.mock
      url = "#{ApiClient.config.path[path]}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.delete(url, header)
      build(response, url)
    end

    alias_method :destroy, :delete

    # Removes the root node attribute if found.
    #
    # @param [Hash] attributes the hash with attributes.
    # @return [Hash] the hash with attributes without the root node.
    def remove_root(attributes = {})
      attributes = attributes[self.root_node.to_sym] if attributes.key?(self.root_node.to_sym)
      attributes = attributes[self.root_node.to_s] if attributes.key?(self.root_node.to_s)
      attributes
    end

    protected

    # Initialize an object based on a hash of attributes.
    #
    # @param [Response] response requisition response.
    # @param [String] url the url of the requisition.
    # @return [Base] the object initialized.
    def build(response, url)
      return response if ApiClient.config.hydra
      attributes = ApiClient::Parser.response(response, url)
      hash = remove_root(attributes)
      hash = hash.merge({ 'response' => attributes })
      new(hash)
    end
  end
end