require 'spec_helper'

describe ApiClient::Dispatcher do
  describe "#_get" do
    before :each do
      FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the response code and body" do
      ApiClient::Base._get("http://api.example.com/user/5").should be_a(Net::HTTPOK)
    end
  end

  describe "#_post" do
    before :each do
      FakeWeb.register_uri(:post, "http://api.example.com/user/5", :status => "201")
    end

    it "should return the response code and body" do
      ApiClient::Base._post("http://api.example.com/user/5", {}).should be_a(Net::HTTPCreated)
    end
  end
end