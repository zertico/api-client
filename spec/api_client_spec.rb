require 'spec_helper'

describe ApiClient do
  describe "#get" do
    context "when response code is 404" do
      before :each do
        FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "404")
      end

      it "should return a NotFound exception" do
        lambda { ApiClient.get('http://api.example.com/user/5') }.should raise_error(ApiClient::Exceptions::NotFound)
      end
    end

    context "when response code is not 404" do
      before :each do
        FakeWeb.register_uri(:get, "http://api.example.com/user/5", :status => "201", :body => "User#3333")
      end

      it "should return the response body" do
        ApiClient.get('http://api.example.com/user/5').should == "User#3333"
      end
    end
  end
end