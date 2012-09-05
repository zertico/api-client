require "active_model"

module ApiClient
  # ApiClient::Base provides a way to make easy api requests as well as making possible to use it inside rails.
  # A possible implementation:
  #  class Car < ApiClient::Base
  #    attr_accessor :color, :name, :year
  #  end
  # This class will handle Rails form as well as it works with respond_with.
  class Base
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    # Initialize an object based on a hash of attributes.
    #
    # @param [Hash] attributes object attributes.
    # @return [Base] the object initialized.
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    # Return the Remote Object Name.
    #
    # @return [String] a string with the remote object class name.
    def self.remote_object
      @remote_object.blank? ? self.to_s.split('::').last.downcase : @remote_object
    end

    # Set a custom remote object name instead of the virtual class name.
    #
    # @param [String] remote_object name.
    def self.remote_object=(remote_object)
      @remote_object = remote_object
    end

    # Return if a object is persisted on the database or not.
    #
    # @return [False] always return false.
    def persisted?
      false
    end

    # Return the hash of errors if existent, otherwise instantiate a new ApiClient::Errors object with self.
    #
    # @return [ApiClient::Errors] the validation errors.
    def errors
      @errors ||= Errors.new(self)
    end

    # Set the hash of errors, making keys symbolic.
    #
    # @param [Hash] errors of the object..
    def errors=(errs = {})
      @errors = Errors.new(self)
      @errors.add_errors(Hash[errs.map{|(key,value)| [key.to_sym,value]}])
    end

    protected

    def self.method_missing(method, *args)
      return super unless Dispatcher.respond_to?(method)
      json_object = Parser.response(Dispatcher.send(method, *args), remote_object)
      return json_object.map { |a| new(a) } if json_object.instance_of?(Array)
      new(json_object)
    end
  end
end
