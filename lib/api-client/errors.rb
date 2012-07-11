require "active_model"

# ApiClient::Errors provide extra functionality to ActiveModel::Errors.
class ApiClient::Errors < ActiveModel::Errors
  # Create a hash of attributes with unique validation error messages.
  #
  # Example:
  #    user.errors.unique_messages   #=> { :name => [ can't be empty and is invalid ]}
  #
  # @return [Hash] The hash of attributes with a unique error message.
  #
  def unique_messages
    errors = {}
    to_hash.each do |attribute, messages| errors[attribute] = messages.join(" and ") end
    errors
  end
end