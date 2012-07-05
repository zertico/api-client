require 'spec_helper'

describe ApiClient::Base do
  let(:user) { User.new(:a => "a", :b => "b") }

  describe "#patch" do
    context "when connection is refused" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :exception => Errno::ECONNREFUSED)
      end

      it "should return a ConnectionRefused exception" do
        lambda { ApiClient::Base.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::ConnectionRefused)
      end
    end

    context "when response code is 401" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "401")
      end

      it "should return a Unauthorized exception" do
        lambda { ApiClient::Base.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::Unauthorized)
      end
    end

    context "when response code is 403" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "403")
      end

      it "should return a Forbidden exception" do
        lambda { ApiClient::Base.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::Forbidden)
      end
    end

    context "when response code is 404" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "404")
      end

      it "should return a NotFound exception" do
        lambda { ApiClient::Base.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::NotFound)
      end
    end

    context "when response code is 500" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "500")
      end

      it "should return a InternalServerError exception" do
        lambda { ApiClient::Base.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::InternalServerError)
      end
    end

    context "when response code is 502" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "502")
      end

      it "should return a BadGateway exception" do
        lambda { ApiClient::Base.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::BadGateway)
      end
    end

    context "when response code is 503" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "503")
      end

      it "should return a ServiceUnavailable exception" do
        lambda { ApiClient::Base.patch('http://api.example.com/user/5', {}) }.should raise_error(ApiClient::Exceptions::ServiceUnavailable)
      end
    end

    context "when response code is 2xx" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com/user/5", :status => "201", :body => '{"a": "a", "b": "b"}')
        User.stub(:new).and_return(user)
      end

      it "should return a object initialized with the response" do
        User.patch('http://api.example.com/user/5', {}).should == user
      end
    end

    context "with a specified port" do
      before :each do
        FakeWeb.register_uri(:patch, "http://api.example.com:3001/user/5", :status => "201", :body => '{"a": "a", "b": "b"}')
        User.stub(:new).and_return(user)
      end

      it "should return a object initialized with the response" do
        User.patch('http://api.example.com:3001/user/5', {}).should == user
      end
    end
  end
end