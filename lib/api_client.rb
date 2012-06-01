require "api_client/version"
require "net/http"

module ApiClient
  autoload :Exceptions, 'api_client/exceptions'

  def self.get(url = '')
    response = Net::HTTP.get_response(URI.parse(url))
    raise_exception(response.code)
    response.body
  end

  def self.post(url = '', args = {})
    response = Net::HTTP.post_form(URI.parse(url), args)
    raise_exception(response.code)
    response.body
  end

  def self.raise_exception(code)
    case code
      when '401' then raise ApiClient::Exceptions::Unauthorized
      when '403' then raise ApiClient::Exceptions::Forbidden
      when '404' then raise ApiClient::Exceptions::NotFound
      when '500' then raise ApiClient::Exceptions::InternalServerError
      when '502' then raise ApiClient::Exceptions::BadGateway
      when '503' then raise ApiClient::Exceptions::ServiceUnavailable
    end
  end
end