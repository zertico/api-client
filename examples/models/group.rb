class Group < ApiClient::Base
  self.associations = { :members => "User", :owner => "Admin" }
end