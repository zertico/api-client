class User < ApiClient::Base
  self.associations = { :groups => 'Group', :books => 'Book' }

  # Any of this fields can be called to manage rails form.
  attr_accessor :email, :password, :password_confirmation, :type

  # Validations will work as well
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
end