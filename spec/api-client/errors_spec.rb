require 'spec_helper'

describe ApiClient::Errors do
  describe '#add_errors' do
    before :each do
      @errors = ApiClient::Errors.new(self).add_errors({ :a => 'b' })
    end

    it 'should initialize a new object' do
      @errors[:a].should == 'b'
    end
  end

  describe '#unique_messages' do
    before :each do
      @user = User.new
      @user.valid?
    end

    it 'should set a unique message for each attribute' do
      @user.errors.unique_messages.should == { :a => "can't be blank and is not included in the list" }
    end
  end

  describe '#unique_message' do
    before :each do
      @user = User.new
      @user.valid?
    end

    it 'should return a unique message for the given attribute' do
      @user.errors.unique_message(:a).should == "can't be blank and is not included in the list"
    end
  end
end