require 'spec_helper'

describe ApiClient::ClassMethods do
  before :each do
    stub_request(:any, 'http://api.example.com/users').to_return(:body => {'a' => 'b'}.to_json)
    stub_request(:any, 'http://api.example.com/users/1').to_return(:body => {'a' => 'b'}.to_json)
  end

  context '.build' do
    context 'with a root node' do
      it 'should return a new object' do
        User.build('user' => { 'a' => 'b'}).should be_an_instance_of(User)
      end

      it 'should set the response' do
        User.build('user' => { 'a' => 'b'}).response.should == { 'user' => { 'a' => 'b' } }
      end
    end

    context 'without a root node' do
      it 'should return a new object' do
        User.build('a' => 'b').should be_an_instance_of(User)
      end

      it 'should set the response' do
        User.build('a' => 'b').response.should == { 'a' => 'b' }
      end
    end
  end

  context '.get' do
    it 'should return a new object' do
      User.get(1).should be_an_instance_of(User)
    end
  end

  context '.post' do
    it 'should return a new object' do
      User.post({}).should be_an_instance_of(User)
    end
  end

  context '.put' do
    it 'should return a new object' do
      User.put(1, {}).should be_an_instance_of(User)
    end
  end

  context '.patch' do
    it 'should return a new object' do
      User.patch(1, {}).should be_an_instance_of(User)
    end
  end

  context '.delete' do
    it 'should return a new object' do
      User.delete(1).should be_an_instance_of(User)
    end
  end
end