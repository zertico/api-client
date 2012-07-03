require "net/http"

module ApiClient::Dispatcher
  def _get(url = '')
    Net::HTTP.get_response(URI.parse(url))
  end

  def _post(url = '', args = {})
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.post(uri.path, args.to_json, { 'Content-Type' => 'application/json' })
  end
end