module Net
  class HTTP
    # Sends a PATCH request to the +path+ and gets a response,
    # as an HTTPResponse object.
    def patch(path, data, initheader = nil, dest = nil, &block) # :yield: +body_segment+
      send_entity(path, data, initheader, dest, Patch, &block)
    end unless HTTP.respond_to?(:patch)

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