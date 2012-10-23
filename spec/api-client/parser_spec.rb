require 'spec_helper'

describe ApiClient::Parser do
  describe "#response" do
    context "with a valid json response" do
      before :each do
        stub_request(:post, "http://api.example.com/user/5").to_return(:body => {:base => { :a => :b } }.to_json, :status => "201")
        @response = ApiClient::Dispatcher.post('http://api.example.com/user/5', {}, {})
      end

      it "should return the response code and the body parsed" do
        ApiClient::Parser.response(@response).should == { "base" => { "a" => "b" } }
      end
    end

    context "with a invalid json response" do
      before :each do
        stub_request(:post, "http://api.example.com/user/5").to_return(:body => "wrong", :status => "201")
        @response = ApiClient::Dispatcher.post('http://api.example.com/user/5', {}, {})
      end

      it "should return the response code and an empty hash" do
        ApiClient::Parser.response(@response).should == {}
      end
    end

    context "with a response code of" do
      context "401" do
        before :each do
          stub_request(:get, "http://api.example.com/user/5").to_return(:status => 401)
          @response = ApiClient::Dispatcher.get('http://api.example.com/user/5')
        end

        it "should return a Unauthorized exception" do
          lambda { ApiClient::Parser.response(@response) }.should raise_error(ApiClient::Exceptions::Unauthorized)
        end
      end

      context "403" do
        before :each do
          stub_request(:get, "http://api.example.com/user/5").to_return(:status => 403)
          @response = ApiClient::Dispatcher.get('http://api.example.com/user/5')
        end

        it "should return a Forbidden exception" do
          lambda { ApiClient::Parser.response(@response) }.should raise_error(ApiClient::Exceptions::Forbidden)
        end
      end

      context "404" do
        before :each do
          stub_request(:get, "http://api.example.com/user/5").to_return(:status => 404)
          @response = ApiClient::Dispatcher.get('http://api.example.com/user/5')
        end

        it "should return a NotFound exception" do
          lambda { ApiClient::Parser.response(@response) }.should raise_error(ApiClient::Exceptions::NotFound, "http://api.example.com/user/5")
        end
      end

      context "500" do
        before :each do
          stub_request(:get, "http://api.example.com/user/5").to_return(:status => 500)
          @response = ApiClient::Dispatcher.get('http://api.example.com/user/5')
        end

        it "should return a InternalServerError exception" do
          lambda { ApiClient::Parser.response(@response) }.should raise_error(ApiClient::Exceptions::InternalServerError)
        end
      end

      context "502" do
        before :each do
          stub_request(:get, "http://api.example.com/user/5").to_return(:status => 502)
          @response = ApiClient::Dispatcher.get('http://api.example.com/user/5')
        end

        it "should return a BadGateway exception" do
          lambda { ApiClient::Parser.response(@response) }.should raise_error(ApiClient::Exceptions::BadGateway)
        end
      end

      context "503" do
        before :each do
          stub_request(:get, "http://api.example.com/user/5").to_return(:status => 503)
          @response = ApiClient::Dispatcher.get('http://api.example.com/user/5')
        end

        it "should return a ServiceUnavailable exception" do
          lambda { ApiClient::Parser.response(@response) }.should raise_error(ApiClient::Exceptions::ServiceUnavailable)
        end
      end
    end
  end
end
