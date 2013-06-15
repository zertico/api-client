class Group < ApiClient::Base
  self.associations = { :members => 'User', :owner => 'Admin' }
  self.root_node = 'people'
end