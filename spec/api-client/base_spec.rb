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
end