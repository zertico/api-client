class Admin < ApiClient::Base
  self.remote_object = "user"
  self.association = { :groups => "Group" }

  # Any of this fields can be called to manage rails form.
  attr_accessor :id, :email, :password, :password_confirmation

  # Validations will work as well
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
end