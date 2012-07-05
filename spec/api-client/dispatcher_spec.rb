require 'spec_helper'

describe ApiClient::Dispatcher do
  describe "#_get" do
    before :each do
      FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the response code and body" do
      ApiClient::Base._get("http://api.example.com/user/5", {}).should be_a(Net::HTTPOK)
    end
  end

  describe "#_post" do
    before :each do
      FakeWeb.register_uri(:post, "http://api.example.com/user/5", :status => "201")
    end

    it "should return the response code and body" do
      ApiClient::Base._post("http://api.example.com/user/5", {}, {}).should be_a(Net::HTTPCreated)
    end
  end

  describe "#_put" do
    before :each do
      FakeWeb.register_uri(:put, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the response code and body" do
      ApiClient::Base._put("http://api.example.com/user/5", {}, {}).should be_a(Net::HTTPOK)
    end
  end

  describe "#_patch" do
    before :each do
      FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the response code and body" do
      ApiClient::Base._patch("http://api.example.com/user/5", {}, {}).should be_a(Net::HTTPOK)
    end
  end

  describe "#_delete" do
    before :each do
      FakeWeb.register_uri(:delete, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the response code and body" do
      ApiClient::Base._delete("http://api.example.com/user/5", {}).should be_a(Net::HTTPOK)
    end
  end
end