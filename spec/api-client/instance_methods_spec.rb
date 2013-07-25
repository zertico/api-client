require 'spec_helper'

describe ApiClient::InstanceMethods do
  let(:user) { User.new(:id => 1) }

  context 'with mock equal false' do
    before :each do
      stub_request(:any, 'http://api.example.com/users').to_return(:body => {'a' => 'b'}.to_json)
      stub_request(:any, 'http://api.example.com/users/1').to_return(:body => {'a' => 'b'}.to_json)
    end

    context '.update' do
      context 'with a root node' do
        it 'should update the object' do
          user.update('user' => { 'a' => 'b'}).should be_an_instance_of(User)
        end

        it 'should set the response' do
          user.update('user' => { 'a' => 'b'}).response.should == { 'user' => { 'a' => 'b' } }
        end
      end

      context 'without a root node' do
        it 'should update the object' do
          user.update('a' => 'b').should be_an_instance_of(User)
        end

        it 'should set the response' do
          user.update('a' => 'b').response.should == { 'a' => 'b' }
        end
      end
    end

    context '.get' do
      it 'should return an user' do
        user.get.should be_an_instance_of(User)
      end
    end

    context '.reload' do
      it 'should return an user' do
        user.reload.should be_an_instance_of(User)
      end
    end

    context '.post' do
      it 'should return an user' do
        user.post.should be_an_instance_of(User)
      end
    end

    context '.create' do
      it 'should return an user' do
        user.create.should be_an_instance_of(User)
      end
    end

    context '.put' do
      it 'should return an user' do
        user.put.should be_an_instance_of(User)
      end
    end

    context '.update_attributes' do
      it 'should return an user' do
        user.update_attributes.should be_an_instance_of(User)
      end
    end

    context '.patch' do
      it 'should return an user' do
        user.patch.should be_an_instance_of(User)
      end
    end

    context '.delete' do
      it 'should return an user' do
        user.delete.should be_an_instance_of(User)
      end
    end

    context '.destroy' do
      it 'should return an user' do
        user.destroy.should be_an_instance_of(User)
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
        user.get.should be_an_instance_of(User)
      end
    end

    context '.reload' do
      it 'should return an user' do
        user.reload.should be_an_instance_of(User)
      end
    end

    context '.post' do
      it 'should return an user' do
        user.post.should be_an_instance_of(User)
      end
    end

    context '.create' do
      it 'should return an user' do
        user.create.should be_an_instance_of(User)
      end
    end

    context '.put' do
      it 'should return an user' do
        user.put.should be_an_instance_of(User)
      end
    end

    context '.update_attributes' do
      it 'should return an user' do
        user.update_attributes.should be_an_instance_of(User)
      end
    end

    context '.patch' do
      it 'should return an user' do
        user.patch.should be_an_instance_of(User)
      end
    end

    context '.delete' do
      it 'should return an user' do
        user.delete.should be_an_instance_of(User)
      end
    end

    context '.destroy' do
      it 'should return an user' do
        user.destroy.should be_an_instance_of(User)
      end
    end
  end
end