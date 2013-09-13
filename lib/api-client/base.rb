require 'active_model'

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

    extend ApiClient::ClassMethods
    include ApiClient::InstanceMethods

    # @return [Integer] the id of the object.
    attr_accessor :id

    # @return [Hash] the request response.
    attr_accessor :response

    # @return [Hash] the errors object.
    attr_reader :errors

    # Initialize an object based on a hash of attributes.
    #
    # @param [Hash] attributes object attributes.
    # @return [Base] the object initialized.
    def initialize(attributes = {})
      @errors = ApiClient::Errors.new(self)
      remove_root(attributes).each do |name, value|
        send("#{name.to_s}=", value)
      end
    end

    # Return if a object is persisted on the database or not.
    #
    # @return [False] always return false.
    def persisted?
      false
    end


    # Return the api name to be used by this model.
    #
    # @return [False] return the default api name.
    def self.path
      @path || :default
    end

    # Return the api name to be used by this model.
    #
    # @return [False] return the default api name.
    def self.path=(path)
      @path = path.to_sym
    end

    # Return the api name to be used by this model.
    #
    # @return [False] return the default api name.
    def path
      self.class.path
    end

    # Return the resource path of the object on the api url.
    #
    # @return [String] the resource path on the api for this object.
    def self.resource_path
      return self.to_s.gsub('::', '/').downcase.pluralize unless @resource_path
      @resource_path
    end

    # Set the resource path of the object on the api.
    #
    # @param [String] resource_path path string.
    def self.resource_path=(resource_path)
      resource_path = resource_path[1, resource_path.size - 1] if resource_path[0, 1] == '/'
      @resource_path = resource_path
    end

    # Return the Root node name for this Class.
    #
    # @return [String] a string with the root node name for this class.
    def self.root_node
      @root_node.blank? ? self.to_s.split('::').last.underscore : @root_node
    end

    # Set a custom root node name instead of the Class name.
    #
    # @param [String] root_node root node name.
    def self.root_node=(root_node)
      @root_node = root_node
    end

    # Set methods to initialize associated objects.
    #
    # @param [Hash] associations classes.
    def self.associations=(associations = {})
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
      alias_method :association=, :associations=
    end

    # Overwrite #attr_acessor method to save instance_variable names.
    #
    # @param [Array] vars instance variables.
    def self.attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat(vars)
      super
    end

    # Return an array with all instance variables setted through attr_accessor.
    #
    # @return [Array] instance variables.
    def self.attributes
      @attributes
    end

    # Return a hash with all instance variables setted through attr_accessor and its currently values.
    #
    # @return [Hash] instance variables and its values.
    def attributes
      self.class.instance_variable_get('@attributes').inject({}) { |hash, attribute| hash.merge(attribute.to_sym => self.send("#{attribute}")) }
    end

    # Update instance values based on a hash
    #
    # @param attr New attributes
    def attributes=(attr = {})
      remove_root(attr).each do |key, value|
        send("#{key}=", value)
      end
    end

    # Return a hash with a root node and all instance variables setted through attr_accessor and its currently values.
    #
    # @return [Hash] instance variables and its values.
    def to_hash
      { self.class.root_node.to_sym => attributes }
    end

    # Initialize a collection of objects. The collection will be an ApiClient::Collection object.
    # The objects in the collection will be all instances of this (ApiClient::Base) class.
    #
    # @param [String] url to get the collection.
    # @return [Collection] a collection of objects.
    def self.collection
      ApiClient::Collection.new(self, self.path, self.resource_path).collection
    end

    class << self
      alias_method :all, :collection
    end

    # Set the hash of errors, making keys symbolic.
    #
    # @param [Hash] errs errors of the object.
    def errors=(errs = {})
      errors.add_errors(Hash[errs.map{|(key,value)| [key.to_sym,value]}])
    end
  end
end