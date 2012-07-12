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

  describe "#persisted?" do
    it "should return false" do
      User.new.should_not be_persisted
    end
  end

  describe "#errors" do
    context "when @errors is not nil" do
      before :each do
        @user = User.new(:errors => {:a => :bc})
      end

      it "should return the errors" do
        @user.errors.should == {:a => :bc}
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

    it "should set @errors with symbolic keys" do
      @user.errors.should == { :a => "message", :b => "message" }
    end
  end
end