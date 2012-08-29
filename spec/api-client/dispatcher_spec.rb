require 'spec_helper'

describe ApiClient::Dispatcher do
  describe "#get" do
    before :each do
      FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the request" do
      ApiClient::Dispatcher.get("http://api.example.com/user/5", {}).should be_a(Net::HTTPOK)
    end

    context "when connection is refused" do
      before :each do
        FakeWeb.register_uri(:get, "http://api.example.com/user/5", :exception => Errno::ECONNREFUSED)
      end

      it "should return a ConnectionRefused exception" do
        lambda { ApiClient::Dispatcher.get('http://api.example.com/user/5') }.should raise_error(ApiClient::Exceptions::ConnectionRefused)
      end
    end
  end

  describe "#post" do
    before :each do
      FakeWeb.register_uri(:post, "http://api.example.com/user/5", :status => "201")
    end

    it "should return the request" do
      ApiClient::Dispatcher.post("http://api.example.com/user/5", {}, {}).should be_a(Net::HTTPCreated)
    end

    context "when connection is refused" do
      before :each do
        FakeWeb.register_uri(:post, "http://api.example.com/user/5", :exception => Errno::ECONNREFUSED)
      end

      it "should return a ConnectionRefused exception" do
        lambda { ApiClient::Dispatcher.post('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::ConnectionRefused)
      end
    end
  end

  describe "#put" do
    before :each do
      FakeWeb.register_uri(:put, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the request" do
      ApiClient::Dispatcher.put("http://api.example.com/user/5", {}, {}).should be_a(Net::HTTPOK)
    end

    context "when connection is refused" do
      before :each do
        FakeWeb.register_uri(:put, "http://api.example.com/user/5", :exception => Errno::ECONNREFUSED)
      end

      it "should return a ConnectionRefused exception" do
        lambda { ApiClient::Dispatcher.put('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::ConnectionRefused)
      end
    end
  end

  describe "#patch" do
    before :each do
      FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the request" do
      ApiClient::Dispatcher.patch("http://api.example.com/user/5", {}, {}).should be_a(Net::HTTPOK)
    end

    context "when connection is refused" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :exception => Errno::ECONNREFUSED)
      end

      it "should return a ConnectionRefused exception" do
        lambda { ApiClient::Dispatcher.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::ConnectionRefused)
      end
    end
  end

  describe "#delete" do
    before :each do
      FakeWeb.register_uri(:delete, "http://api.example.com/user/5", :status => "200")
    end

    it "should return the request" do
      ApiClient::Dispatcher.delete("http://api.example.com/user/5", {}).should be_a(Net::HTTPOK)
    end

    context "when connection is refused" do
      before :each do
        FakeWeb.register_uri(:delete, "http://api.example.com/user/5", :exception => Errno::ECONNREFUSED)
      end

      it "should return a ConnectionRefused exception" do
        lambda { ApiClient::Dispatcher.delete('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::ConnectionRefused)
      end
    end
  end
end