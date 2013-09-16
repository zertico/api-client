# Exception raised when a parallel requisition can' be performed as Typhoeus must be defined on the Project
class ApiClient::Exceptions::NotPossible < ApiClient::Exceptions::Generic
  # Initialize a new exception.
  #
  # @return [NotPossible] a new exception.
  def self.initialize
    super('Typhoeus must be defined to make parallel requests!')
  end
end