require 'spec_helper'

describe ApiClient do
  unless defined?(::Typhoues)
    describe '.parallel' do
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