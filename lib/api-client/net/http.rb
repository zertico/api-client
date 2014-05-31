# Main namespace for default ruby HTTP library to make HTTP requests.
module Net
  # == An HTTP client API for Ruby.
  #
  # Net::HTTP provides a rich library which can be used to build HTTP
  # user-agents.  For more details about HTTP see
  # [RFC2616](http://www.ietf.org/rfc/rfc2616.txt)
  #
  # Net::HTTP is designed to work closely with URI.  URI::HTTP#host,
  # URI::HTTP#port and URI::HTTP#request_uri are designed to work with
  # Net::HTTP.
  class HTTP
    # Send +data+ (must be a String) to +path+ with a PATCH request. +header+ must be a Hash
    # like { 'Accept' => '*/*', ... }.
    #
    # This method returns a Net::HTTPResponse object.
    def patch(path, data, initheader = nil, dest = nil, &block) # :yield: +body_segment+
      res = nil
      request(Patch.new(path, initheader), data) {|r|
        r.read_body dest, &block
        res = r
      }
      unless @newimpl
        res.value
        return res, res.body
      end
      res
    end

    #
    # PATCH method --- RFC5789
    #

    # See Net::HTTPGenericRequest for attributes and methods.
    class Patch < HTTPRequest
      METHOD = 'PATCH'
      REQUEST_HAS_BODY = true
      RESPONSE_HAS_BODY = true
    end
  end
end