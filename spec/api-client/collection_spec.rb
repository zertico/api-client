require 'spec_helper'

describe ApiClient::Collection do
  let(:user) { User.new }

  before :each do
    stub_request(:get, 'http://api.example.com/users').to_return(:body => [ { 'a' => 'b' }, { 'a' => 'b2' } ].to_json)
    User.stub(:new => user)
    @collection = ApiClient::Collection.new(User, 'users')
  end

  it 'should include enumerable module' do
    @collection.should respond_to(:first)
  end

  describe '.initialize' do
    it 'Should initialize a collection of Objects' do
      @collection.collection.should == [user, user]
    end
  end
end