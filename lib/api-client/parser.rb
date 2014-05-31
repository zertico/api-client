require 'json'

# ApiClient::Parser provides a method to parse the request response.
module ApiClient::Parser
  # Parse the JSON response.
  #
  # @param [HTTP] response HTTP object for the request.
  # @param [String] url The url of the requisition.
  # @return [Hash] the body parsed.
  def self.response(response, url)
    raise_exception(response, url)
    begin
      object = ::JSON.parse(response.body)
    rescue ::JSON::ParserError, TypeError
      object = {}
    end
    object
  end

  protected

  # Check if the response was successful, otherwise raise a proper exception.
  #
  # @param [HTTP] response HTTP object for the request.
  # @param [String] url The url of the requisition.
  # @raise [ApiClient::Exceptions::Unauthorized] if the response code status is 401
  # @raise [ApiClient::Exceptions::Forbidden] if the response code status is 403
  # @raise [ApiClient::Exceptions::NotFound] if the response code status is 404
  # @raise [ApiClient::Exceptions::InternalServerError] if the response code status is 500
  # @raise [ApiClient::Exceptions::BadGateway] if the response code status is 502
  # @raise [ApiClient::Exceptions::ServiceUnavailable] if the response code status is 503
  def self.raise_exception(response, url)
    case response.code.to_i
      when 401 then raise ApiClient::Exceptions::Unauthorized
      when 403 then raise ApiClient::Exceptions::Forbidden
      when 404 then raise ApiClient::Exceptions::NotFound.new(url)
      when 500 then raise ApiClient::Exceptions::InternalServerError
      when 502 then raise ApiClient::Exceptions::BadGateway
      when 503 then raise ApiClient::Exceptions::ServiceUnavailable
      else return
    end
  end
end