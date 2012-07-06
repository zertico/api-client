class User < ApiClient::Base
  # Any of this fields can be called to manage rails form.
  attr_accessor :id, :email, :password, :password_confirmation
end