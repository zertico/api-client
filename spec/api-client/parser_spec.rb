require 'spec_helper'

describe ApiClient::Parser do
  describe "#_response" do
    context "with a valid json response" do
      context "without a root node" do
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

      context "with a root node" do
        before :each do
          FakeWeb.register_uri(:post, "http://api.example.com/user/5",
                               :body => { :base => { :a => :b } }.to_json,
                               :status => "201")
          @response = ApiClient::Base._post('http://api.example.com/user/5', {}, {})
        end

        it "should return the response code and the body parsed" do
          ApiClient::Base._response(@response).should == ['201', { "a" => "b" }]
        end
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

  describe "#remote_object" do
    context "on a class without remote object specification" do
      it "should return the class name" do
        User.remote_object.should == "user"
      end
    end

    context "on a class with remote object specification" do
      it "should return the class name" do
        Admin.remote_object.should == "user"
      end
    end
  end

  describe "#remote_object=" do
    it "should set the remote object name" do
      Admin.remote_object.should == "user"
    end
  end
end