require "net/http"

module ApiClient::Dispatcher
  def _get(url, header)
    initialize_connection(url)
    @http.get(@uri.path, header)
  end

  def _post(url, args, header)
    initialize_connection(url)
    @http.post(@uri.path, args.to_json, { 'Content-Type' => 'application/json' }.merge(header))
  end

  def _put(url, args, header)
    initialize_connection(url)
    @http.put(@uri.path, args.to_json, { 'Content-Type' => 'application/json' }.merge(header))
  end

  def _patch(url, args, header)
    initialize_connection(url)
    @http.patch(@uri.path, args.to_json, { 'Content-Type' => 'application/json' }.merge(header))
  end

  def _delete(url, header)
    initialize_connection(url)
    @http.delete(@uri.path, header)
  end

  protected

  def initialize_connection(url = '')
    @uri = URI(url)
    @http = Net::HTTP.new(@uri.host, @uri.port)
  end
end