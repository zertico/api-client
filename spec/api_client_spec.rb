require 'spec_helper'

describe ApiClient do
  describe "#get" do
    context "when response code is 401" do
      before :each do
        FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "401")
      end

      it "should return a Unauthorized exception" do
        lambda { ApiClient.get('http://api.example.com/user/5') }.should raise_error(ApiClient::Exceptions::Unauthorized)
      end
    end

    context "when response code is 403" do
      before :each do
        FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "403")
      end

      it "should return a Forbidden exception" do
        lambda { ApiClient.get('http://api.example.com/user/5') }.should raise_error(ApiClient::Exceptions::Forbidden)
      end
    end

    context "when response code is 404" do
      before :each do
        FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "404")
      end

      it "should return a NotFound exception" do
        lambda { ApiClient.get('http://api.example.com/user/5') }.should raise_error(ApiClient::Exceptions::NotFound)
      end
    end

    context "when response code is 2xx" do
      before :each do
        FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "201", :body => "User#3333")
      end

      it "should return the response body" do
        ApiClient.get('http://api.example.com/user/5').should == "User#3333"
      end
    end
  end

  describe "#post" do
    context "when response code is 401" do
      before :each do
        FakeWeb.register_uri(:post, "http://api.example.com/user/5", :status => "401")
      end

      it "should return a Unauthorized exception" do
        lambda { ApiClient.post('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::Unauthorized)
      end
    end

    context "when response code is 403" do
      before :each do
        FakeWeb.register_uri(:post, "http://api.example.com/user/5", :status => "403")
      end

      it "should return a Forbidden exception" do
        lambda { ApiClient.post('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::Forbidden)
      end
    end

    context "when response code is 404" do
      before :each do
        FakeWeb.register_uri(:post, "http://api.example.com/user/5", :status => "404")
      end

      it "should return a NotFound exception" do
        lambda { ApiClient.post('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::NotFound)
      end
    end

    context "when response code is 2xx" do
      before :each do
        FakeWeb.register_uri(:post, "http://api.example.com/user/5", :status => "201", :body => "User#3333")
      end

      it "should return the response body" do
        ApiClient.post('http://api.example.com/user/5', {}).should == "User#3333"
      end
    end
  end
end