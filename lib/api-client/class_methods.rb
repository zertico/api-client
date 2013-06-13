module ApiClient
  # This module handles the logic to make an api call and initialize an object with the response.
  module ClassMethods
    # Initialize an object based on a hash of attributes.
    #
    # @param [Hash] attributes hash of attributes.
    # @return [Base] the object initialized.
    def build(attributes)
      hash = remove_root(attributes)
      hash = hash.merge({ 'response' => attributes })
      new(hash)
    end

    # Make a get requisition and initialize an object with the response.
    #
    # @param [Integer] id id of the object.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def get(id, header = {})
      url = "#{ApiClient.config.path}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.get(url, header)
      params = ApiClient::Parser.response(response, url)
      build(params)
    end

    # Make a post requisition and initialize an object with the response.
    #
    # @param [Hash] attributes hash with the attributes to send.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def post(attributes, header = {})
      url = "#{ApiClient.config.path}#{self.resource_path}"
      response = ApiClient::Dispatcher.post(url, attributes, header)
      params = ApiClient::Parser.response(response, url)
      build(params)
    end

    # Make a put requisition and initialize an object with the response.
    #
    # @param [Integer] id id of the object.
    # @param [Hash] attributes hash with the attributes to send.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def put(id, attributes, header = {})
      url = "#{ApiClient.config.path}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.put(url, attributes, header)
      params = ApiClient::Parser.response(response, url)
      build(params)
    end

    # Make a patch requisition and initialize an object with the response.
    #
    # @param [Integer] id id of the object.
    # @param [Hash] attributes hash with the attributes to send.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def patch(id, attributes, header = {})
      url = "#{ApiClient.config.path}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.patch(url, attributes, header)
      params = ApiClient::Parser.response(response, url)
      build(params)
    end

    # Make a delete requisition and initialize an object with the response.
    #
    # @param [Integer] id id of the object.
    # @param [Hash] header hash with the header options.
    # @return [Base] the object initialized.
    def delete(id, header = {})
      url = "#{ApiClient.config.path}#{self.resource_path}/#{id}"
      response = ApiClient::Dispatcher.delete(url, header)
      params = ApiClient::Parser.response(response, url)
      build(params)
    end

    def remove_root(attributes = {})
      attributes = attributes[self.root_node.to_sym] if attributes.key?(self.root_node.to_sym)
      attributes = attributes[self.root_node.to_s] if attributes.key?(self.root_node.to_s)
      attributes
    end
  end
end