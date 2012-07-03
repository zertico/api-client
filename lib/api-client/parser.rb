module ApiClient::Parser
  def _response(response)
    begin
      body = JSON.parse(response.body)
    rescue JSON::ParserError
      body = nil
    end
    return response.code, body
  end
end