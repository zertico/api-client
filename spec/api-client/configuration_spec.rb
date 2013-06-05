require 'spec_helper'

describe ApiClient::Configuration do
  describe '#path' do
    describe 'when not configured' do
      before :each do
        ApiClient.configure do |config|
          config.path = ''
        end
      end

      it 'should raise an error' do
        lambda { ApiClient.config.path }.should raise_error(ApiClient::Exceptions::NotConfigured)
      end
    end

    describe 'when properly configured' do
      before :each do
        ApiClient.configure do |config|
          config.path = 'http://api.example.com'
        end
      end

      it 'should return the path value' do
        ApiClient.config.path.should_not be_nil
      end
    end
  end

  describe '#path=' do
    describe "with a string without '/'" do
      before :each do
        ApiClient.config.path = 'http://api.example.com'
      end

      it "should set it with a '/'" do
        ApiClient.config.path.should == 'http://api.example.com/'
      end
    end

    describe "with a string with '/'" do
      before :each do
        ApiClient.config.path = 'http://api.example.com/'
      end

      it "should set it as passed" do
        ApiClient.config.path.should == 'http://api.example.com/'
      end
    end
  end
end