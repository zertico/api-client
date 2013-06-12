require 'rspec'
require 'webmock/rspec'
require 'json'
require 'coveralls'

Coveralls.wear!

require "#{File.dirname(__FILE__)}/../lib/api-client"

class User < ApiClient::Base
  attr_accessor :a, :b

  validates_presence_of :a
  validates_inclusion_of :a, :in => %w(a A)
end

class Admin < ApiClient::Base
  self.root_node = 'user'

  attr_accessor :a, :b
end

class Post < ApiClient::Base
  self.association = { :writer => 'User' }

  attr_accessor :a
end

class Group < ApiClient::Base
  self.associations = { :members => 'User', :owner => 'Admin' }
end

ApiClient.configure do |config|
  config.path = 'http://api.example.com'
end