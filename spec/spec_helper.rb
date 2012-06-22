require "rspec"
require "fakeweb"
require "json"

require File.dirname(__FILE__) + "/../lib/api-client"

class User < ApiClient::Base
  attr_accessor :a, :b
end