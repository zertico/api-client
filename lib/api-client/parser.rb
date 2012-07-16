# ApiClient::Parser provides a method to parse the request response.
module ApiClient::Parser
  # Parse the JSON response.
  #
  # @param [HTTP] response HTTP object for the request.
  # @return [Array] the code and the body parsed.
  def _response(response)
    begin
      object = JSON.parse(response.body)
      object = object[remote_object] if object.key?(remote_object)
      object = object[remote_object.pluralize] if object.key?(remote_object.pluralize)
    rescue JSON::ParserError
      object = nil
    end
    return response.code, object
  end

  # Return the Remote Object Name.
  #
  # @return [String] a string with the remote object class name.
  def remote_object
    @remote_object.blank? ? self.to_s.split('::').last.downcase : @remote_object
  end

  # Set a custom remote object name instead of the virtual class name.
  #
  # @param [String] remote_object name.
  def remote_object=(remote_object)
    @remote_object = remote_object
  end
end