require "api_client/version"
require "net/http"

module ApiClient
  autoload :Exceptions, 'api_client/exceptions'

  def self.get(url)
    response = Net::HTTP.get_response(URI.parse(url))
    raise ApiClient::Exceptions::NotFound if response.code == '404'
    response.body
  end
end