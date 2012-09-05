require "active_model"

# ApiClient::Errors provide extra functionality to ActiveModel::Errors.
class ApiClient::Errors < ActiveModel::Errors
  # Add serveral errors from a hash to the object.
  #
  # @return [ApiClient::Errors] The Error object.
  def add_errors(errors = {})
    errors.each_pair do |key, value|
      add(key, value)
    end
  end

  # Returns a unique message for each array of error messages in a hash.
  #
  #   class Person
  #     validates_presence_of :name, :address, :email
  #     validates_length_of :name, in: 5..30
  #   end
  #
  #   person = Person.create(address: '123 First St.')
  #   person.errors.unique_messages
  #   # => { :name => "is too short (minimum is 5 characters) and can't be blank", :address => nil, :email => "can't be blank" }
  def unique_messages
    errors = {}
    map { |attribute, messages| errors[attribute] = unique_message(attribute) }
    errors
  end

  # Returns a unique message for a given attribute.
  #
  #   class Person
  #     validates_presence_of :name, :address, :email
  #     validates_length_of :name, in: 5..30
  #   end
  #
  #   person = Person.create(address: '123 First St.')
  #   person.errors.unique_message(:name) # => "is too short (minimum is 5 characters) and can't be blank"
  #   person.errors.unique_message(:address) # => nil
  def unique_message(attribute)
    return '' if messages[attribute].blank?
    [messages[attribute]].flatten.to_sentence
  end
end
