require "rspec"
require "fakeweb"
require "json"

require File.dirname(__FILE__) + "/../lib/api-client"

class User < ApiClient::Base
  attr_accessor :a, :b

  validates_presence_of :a
  validates_inclusion_of :a, :in => %w(a A)
end

class Admin < ApiClient::Base
  self.remote_object = "user"

  attr_accessor :a, :b
end