require 'spec_helper'

describe ApiClient::Parser do
  describe "#_response" do
    context "with a valid json response" do
      before :each do
        FakeWeb.register_uri(:post, "http://api.example.com/user/5",
                             :body => { :a => :b }.to_json,
                             :status => "201")
        @response = ApiClient::Base._post('http://api.example.com/user/5', {}, {})
      end

      it "should return the response code and the body parsed" do
        ApiClient::Base._response(@response).should == ['201', { "a" => "b" }]
      end
    end

    context "with a invalid json response" do
      before :each do
        FakeWeb.register_uri(:post, "http://api.example.com/user/5",
                             :body => "wrong",
                             :status => "201")
        @response = ApiClient::Base._post('http://api.example.com/user/5', {}, {})
      end

      it "should return the response code and a nil body" do
        ApiClient::Base._response(@response).should == ['201', nil]
      end
    end
  end
end