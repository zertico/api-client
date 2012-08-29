require 'spec_helper'

describe ApiClient::Errors do
  describe "#unique_messages" do
    before :each do
      @user = User.new
      @user.valid?
    end

    it "should set a unique message for each attribute" do
      @user.errors.unique_messages.should == { :a => "can't be blank and is not included in the list" }
    end
  end
end