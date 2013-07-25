require 'spec_helper'

describe ApiClient::ClassMethods do
  context 'with mock equal false' do
    before :each do
      stub_request(:any, 'http://api.example.com/users').to_return(:body => {'a' => 'b'}.to_json)
      stub_request(:any, 'http://api.example.com/users/1').to_return(:body => {'a' => 'b'}.to_json)
    end

    context '.build' do
      context 'with a root node' do
        it 'should return an user' do
          User.build('user' => { 'a' => 'b'}).should be_an_instance_of(User)
        end

        it 'should set the response' do
          User.build('user' => { 'a' => 'b'}).response.should == { 'user' => { 'a' => 'b' } }
        end
      end

      context 'without a root node' do
        it 'should return an user' do
          User.build('a' => 'b').should be_an_instance_of(User)
        end

        it 'should set the response' do
          User.build('a' => 'b').response.should == { 'a' => 'b' }
        end
      end
    end

    context '.get' do
      it 'should return an user' do
        User.get(1).should be_an_instance_of(User)
      end
    end

    context '.find' do
      it 'should return an user' do
        User.find(1).should be_an_instance_of(User)
      end
    end

    context '.post' do
      it 'should return an user' do
        User.post({}).should be_an_instance_of(User)
      end
    end

    context '.create' do
      it 'should return an user' do
        User.create({}).should be_an_instance_of(User)
      end
    end

    context '.put' do
      it 'should return an user' do
        User.put(1, {}).should be_an_instance_of(User)
      end
    end

    context '.update_attributes' do
      it 'should return an user' do
        User.update_attributes(1, {}).should be_an_instance_of(User)
      end
    end

    context '.patch' do
      it 'should return an user' do
        User.patch(1, {}).should be_an_instance_of(User)
      end
    end

    context '.delete' do
      it 'should return an user' do
        User.delete(1).should be_an_instance_of(User)
      end
    end

    context '.destroy' do
      it 'should return an user' do
        User.destroy(1).should be_an_instance_of(User)
      end
    end
  end

  context 'with mock equal true' do
    before :each do
      ApiClient.configure do |config|
        config.mock = true
      end
    end

    after :each do
      ApiClient.configure do |config|
        config.mock = false
      end
    end

    context '.get' do
      it 'should return an user' do
        User.get(1).should be_an_instance_of(User)
      end
    end

    context '.find' do
      it 'should return an user' do
        User.find(1).should be_an_instance_of(User)
      end
    end

    context '.post' do
      it 'should return an user' do
        User.post({}).should be_an_instance_of(User)
      end
    end

    context '.create' do
      it 'should return an user' do
        User.create({}).should be_an_instance_of(User)
      end
    end

    context '.put' do
      it 'should return an user' do
        User.put({}).should be_an_instance_of(User)
      end
    end

    context '.update_attributes' do
      it 'should return an user' do
        User.update_attributes({}).should be_an_instance_of(User)
      end
    end

    context '.patch' do
      it 'should return an user' do
        User.patch({}).should be_an_instance_of(User)
      end
    end

    context '.delete' do
      it 'should return an user' do
        User.delete(1).should be_an_instance_of(User)
      end
    end

    context '.destroy' do
      it 'should return an user' do
        User.destroy(1).should be_an_instance_of(User)
      end
    end
  end
end