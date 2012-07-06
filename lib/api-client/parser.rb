# ApiClient::Parser provides a method to parse the request response.
module ApiClient::Parser
  # Parse the JSON response.
  #
  # @param [HTTP] response HTTP object for the request.
  # @return [Array] the code and the body parsed.
  def _response(response)
    begin
      body = JSON.parse(response.body)
    rescue JSON::ParserError
      body = nil
    end
    return response.code, body
  end
end