require "active_model"

# ApiClient::Base provides a way to make easy api requests as well as making possible to use it inside rails.
# A possible implementation:
#  class Car < ApiClient::Base
#    attr_accessor :color, :name, :year
#  end
# This class will handle Rails form as well as it works with respond_with.
class ApiClient::Base
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  extend ApiClient::Parser
  extend ApiClient::Dispatcher

  # Initialize an object based on a hash of a attributes.
  #
  # @param [Hash] attributes object attributes.
  # @return [Base] the object initialized.
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  # Return if a object is persisted on the database or not.
  #
  # @return [False] it will always return false.
  def persisted?
    false
  end

  # Make a get request and returns a new instance with te response attributes.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [Base] a new object initialized with the response.
  # @raise [ApiClient::Exceptions::ConnectionRefused] The request was refused by the api.
  # @raise [ApiClient::Exceptions::Unauthorized] The request requires user authentication.
  # @raise [ApiClient::Exceptions::Forbidden] The request was refused.
  # @raise [ApiClient::Exceptions::NotFound] The request uri has not be found.
  # @raise [ApiClient::Exceptions::InternalServerError] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::BadGateway] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::ServiceUnavailable] The api was unable to handle the request.
  def self.get(url = '', header = {})
    dispatch { _get(url, header) }
  end

  # Make a post request and returns a new instance with te response attributes.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Base] a new object initialized with the response.
  # @raise [ApiClient::Exceptions::ConnectionRefused] The request was refused by the api.
  # @raise [ApiClient::Exceptions::Unauthorized] The request requires user authentication.
  # @raise [ApiClient::Exceptions::Forbidden] The request was refused.
  # @raise [ApiClient::Exceptions::NotFound] The request uri has not be found.
  # @raise [ApiClient::Exceptions::InternalServerError] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::BadGateway] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::ServiceUnavailable] The api was unable to handle the request.
  def self.post(url = '', args = {}, header = {})
    dispatch { _post(url, args, header) }
  end

  # Make a put request and returns a new instance with te response attributes.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Base] a new object initialized with the response.
  # @raise [ApiClient::Exceptions::ConnectionRefused] The request was refused by the api.
  # @raise [ApiClient::Exceptions::Unauthorized] The request requires user authentication.
  # @raise [ApiClient::Exceptions::Forbidden] The request was refused.
  # @raise [ApiClient::Exceptions::NotFound] The request uri has not be found.
  # @raise [ApiClient::Exceptions::InternalServerError] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::BadGateway] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::ServiceUnavailable] The api was unable to handle the request.
  def self.put(url = '', args = {}, header = {})
    dispatch { _put(url, args, header) }
  end

  # Make a patch request and returns a new instance with te response attributes.
  #
  # @param [String] url of the api request.
  # @param [Hash] args attributes of object.
  # @param [Hash] header attributes of the request.
  # @return [Base] a new object initialized with the response.
  # @raise [ApiClient::Exceptions::ConnectionRefused] The request was refused by the api.
  # @raise [ApiClient::Exceptions::Unauthorized] The request requires user authentication.
  # @raise [ApiClient::Exceptions::Forbidden] The request was refused.
  # @raise [ApiClient::Exceptions::NotFound] The request uri has not be found.
  # @raise [ApiClient::Exceptions::InternalServerError] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::BadGateway] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::ServiceUnavailable] The api was unable to handle the request.
  def self.patch(url = '', args = {}, header = {})
    dispatch { _patch(url, args, header) }
  end

  # Make a delete request and returns a new instance with te response attributes.
  #
  # @param [String] url of the api request.
  # @param [Hash] header attributes of the request.
  # @return [Base] a new object initialized with the response.
  # @raise [ApiClient::Exceptions::ConnectionRefused] The request was refused by the api.
  # @raise [ApiClient::Exceptions::Unauthorized] The request requires user authentication.
  # @raise [ApiClient::Exceptions::Forbidden] The request was refused.
  # @raise [ApiClient::Exceptions::NotFound] The request uri has not be found.
  # @raise [ApiClient::Exceptions::InternalServerError] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::BadGateway] The request was not fulfilled by the api.
  # @raise [ApiClient::Exceptions::ServiceUnavailable] The api was unable to handle the request.
  def self.delete(url = '', header = {})
    dispatch { _delete(url, header) }
  end

  protected

  def self.dispatch
    begin
      code, body = _response(yield)
    rescue Errno::ECONNREFUSED
      raise ApiClient::Exceptions::ConnectionRefused
    end
    raise_exception(code)
    new(body)
  end

  def self.raise_exception(code)
    case code
      when '401' then raise ApiClient::Exceptions::Unauthorized
      when '403' then raise ApiClient::Exceptions::Forbidden
      when '404' then raise ApiClient::Exceptions::NotFound
      when '500' then raise ApiClient::Exceptions::InternalServerError
      when '502' then raise ApiClient::Exceptions::BadGateway
      when '503' then raise ApiClient::Exceptions::ServiceUnavailable
      else return
    end
  end
end