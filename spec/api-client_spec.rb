require 'spec_helper'

describe ApiClient do
  describe '.parallel' do
    if defined?(::Typhoues)
      before :each do
        stub_request(:any, 'http://api.example.com/users/1').to_return(:body => {'a' => '1'}.to_json)
        stub_request(:any, 'http://api.example.com/users/2').to_return(:body => {'a' => '2'}.to_json)
        stub_request(:any, 'http://api.example.com/users/3').to_return(:body => {'a' => '3'}.to_json)
        stub_request(:any, 'http://api.example.com/users/4').to_return(:body => {'a' => '4'}.to_json)
        stub_request(:any, 'http://api.example.com/users/5').to_return(:body => {'a' => '5'}.to_json)
        @user1 = User.new
        @user2 = User.new
        @user3 = User.new
        @user4 = User.new
        @user5 = User.new
        ApiClient.parallel do
          User.find(1).on_complete_update(@user1)
          User.find(2).on_complete_update(@user2)
          User.find(3).on_complete_update(@user3)
          User.find(4).on_complete_update(@user4)
          User.find(5).on_complete_update(@user5)
        end
      end

      it 'initialize user1' do
        @user1.attributes.should == {}
      end

      it 'initialize user2' do
        @user2.attributes.should == {}
      end

      it 'initialize user3' do
        @user3.attributes.should == {}
      end

      it 'initialize user4' do
        @user4.attributes.should == {}
      end

      it 'initialize user5' do
        @user5.attributes.should == {}
      end
    else
      it 'should raise an exception' do
        expect { ApiClient.parallel {} }.to raise_error(ApiClient::Exceptions::NotPossible)
      end
    end
  end

  context 'settings' do
    it 'should return the configured path' do
      ApiClient.config.path.should == { :default => 'http://api.example.com/' }
    end

    it 'should return the default header' do
      ApiClient.config.header.should == { 'Content-Type' => 'application/json' }
    end

    it 'should have mock equal false' do
      ApiClient.config.mock.should be_false
    end

    it 'should have hydra equal false' do
      ApiClient.config.hydra.should be_false
    end
  end
end