require 'spec_helper'

describe ApiClient::Base do
  describe "#initialize" do
    context "with a hash {:a => 'a', :b => 'b'}" do
      before :each do
        @user = User.new({:a => "a", :b => "b"})
      end

      it "should set #a" do
        @user.a.should == "a"
      end

      it "should set #b" do
        @user.b.should == "b"
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

  describe "#persisted?" do
    it "should return false" do
      User.new.should_not be_persisted
    end
  end

  describe "#errors" do
    context "when @errors is not nil" do
      before :each do
        @user = User.new(:errors => {:a => :invalid})
      end

      it "should return the errors" do
        @user.errors.messages.should == {:a => ['is invalid']}
      end
    end

    context "when @errors is nil" do
      before :each do
        @user = User.new
      end

      it "should instantiate a new instance of ApiClient::Errors" do
        @user.errors.should be_an_instance_of(ApiClient::Errors)
      end
    end
  end

  describe "#errors=" do
    before :each do
      @user = User.new(:errors => { "a" => "message", "b" => "message" })
    end

    it "should set @errors with symbolic keys and messages as an array" do
      @user.errors.messages.should == { :a => %w(message), :b => %w(message) }
    end
  end
end
