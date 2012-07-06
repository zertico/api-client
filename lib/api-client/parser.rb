# ApiClient::Parser provides a method to parse the request response.
module ApiClient::Parser
  # Parse the JSON response.
  #
  # @param [HTTP] response HTTP object for the request.
  # @return [Array] the code and the body parsed.
  def _response(response)
    begin
      body = JSON.parse(response.body)
      root_node =  name.split('::').last.downcase
      object = body.key?(root_node) ? body[root_node] : body
    rescue JSON::ParserError
      object = nil
    end
    return response.code, object
  end
end