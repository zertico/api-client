module ApiClient
  class Base
    def self.get(url = '')
      call do Net::HTTP.get_response(URI.parse(url)) end
    end

    def self.post(url = '', args = {})
      call do Net::HTTP.post_form(URI.parse(url), args) end
    end

    protected

    def self.call
      begin
        response = yield
      rescue Errno::ECONNREFUSED
        raise ApiClient::Exceptions::ConnectionRefused
      end
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
end