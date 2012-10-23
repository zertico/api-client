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

    # @return [Hash] the request response.
    attr_accessor :response

    # @return [Hash] the errors object.
    attr_reader :errors

    # Initialize an object based on a hash of attributes.
    #
    # @param [Hash] attributes object attributes.
    # @return [Base] the object initialized.
    def initialize(attributes = {})
      @errors = Errors.new(self)
      attributes.each do |name, value|
        send("#{name.to_s}=", value)
      end
    end

    # Return if a object is persisted on the database or not.
    #
    # @return [False] always return false.
    def persisted?
      false
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

    # Set methods to initialize associated objects.
    #
    # @param [Hash] association classes.
    def self.associations(associations = {})
      associations.each do |association, class_name|
        class_eval <<-EVAL
          def #{association.to_s}=(attributes = {})
            return @#{association.to_s} = attributes.map { |attr| #{class_name.constantize}.new(attr) } if attributes.instance_of?(Array)
            @#{association.to_s} = #{class_name.constantize}.new(attributes)
          end
          def #{association.to_s}
            @#{association.to_s}
          end
        EVAL
      end
    end

    class << self
      alias_method :association, :associations
    end

    # Overwrite #attr_acessor method to save instance_variable names.
    #
    # @param [Array] instance variables.
    def self.attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super
    end

    # Return an array with all instance variables setted through attr_acessor.
    #
    # @return [Array] instance variables.
    def self.attributes
      @attributes
    end

    # Return an array with all instance variables setted through attr_acessor and its currently values.
    #
    # @return [Hash] instance variables and its values.
    def attributes
      attributes = {}
      self.class.instance_variable_get("@attributes").map { |attribute| attributes[attribute.to_sym] = self.send("#{attribute}") }
      attributes
    end

    alias_method :to_hash, :attributes

    # Set the hash of errors, making keys symbolic.
    #
    # @param [Hash] errors of the object.
    def errors=(errs = {})
      errors.add_errors(Hash[errs.map{|(key,value)| [key.to_sym,value]}])
    end

    protected

    def self.method_missing(method, *args)
      @response = Parser.response(Dispatcher.send(method, *args), *args[0])
      case true
        when @response.instance_of?(Array) then return @response.map { |a| new(a.merge(:response => @response)) }
        when @response.key?(remote_object) then return new(@response[remote_object].merge(:response => @response))
        when @response.key?(remote_object.pluralize) then return @response[remote_object.pluralize].map { |a| new(a.merge(:response => @response)) }
        else return new(@response.merge(:response => @response))
      end
    end
  end
end
