require 'spec_helper'

describe ApiClient::InstanceMethods do
  let(:user) { User.new(:id => 1) }
  
  before :each do
    stub_request(:any, 'http://api.example.com/users').to_return(:body => {'a' => 'b'}.to_json)
    stub_request(:any, 'http://api.example.com/users/1').to_return(:body => {'a' => 'b'}.to_json)
  end

  context '.update_attributes' do
    context 'with a root node' do
      it 'should update the object' do
        user.update_attributes('user' => { 'a' => 'b'}).should be_an_instance_of(User)
      end

      it 'should set the response' do
        user.update_attributes('user' => { 'a' => 'b'}).response.should == { 'user' => { 'a' => 'b' } }
      end
    end

    context 'without a root node' do
      it 'should update the object' do
        user.update_attributes('a' => 'b').should be_an_instance_of(User)
      end

      it 'should set the response' do
        user.update_attributes('a' => 'b').response.should == { 'a' => 'b' }
      end
    end
  end

  context '.get' do
    it 'should return a new object' do
      user.get.should be_an_instance_of(User)
    end
  end

  context '.post' do
    it 'should return a new object' do
      user.post.should be_an_instance_of(User)
    end
  end

  context '.put' do
    it 'should return a new object' do
      user.put.should be_an_instance_of(User)
    end
  end

  context '.patch' do
    it 'should return a new object' do
      user.patch.should be_an_instance_of(User)
    end
  end

  context '.delete' do
    it 'should return a new object' do
      user.delete.should be_an_instance_of(User)
    end
  end
end