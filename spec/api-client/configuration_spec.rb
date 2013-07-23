require 'spec_helper'

describe ApiClient::Configuration do
  describe '#path' do
    context 'when not configured' do
      before :each do
        ApiClient.configure do |config|
          config.path = ''
        end
      end

      it 'should raise an error' do
        lambda { ApiClient.config.path }.should raise_error(ApiClient::Exceptions::NotConfigured)
      end
    end

    context 'when properly configured' do
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
    context "with a string without '/'" do
      before :each do
        ApiClient.config.path = 'http://api.example.com'
      end

      it "should set it with a '/'" do
        ApiClient.config.path.should == 'http://api.example.com/'
      end
    end

    context "with a string with '/'" do
      before :each do
        ApiClient.config.path = 'http://api.example.com/'
      end

      it "should set it as passed" do
        ApiClient.config.path.should == 'http://api.example.com/'
      end
    end
  end

  describe '#header' do
    context 'when not configured' do
      it 'should return a hash with configs for content_type only' do
        ApiClient.config.header.should == { 'Content-Type' => 'application/json' }
      end
    end

    context 'when configured' do
      before :each do
        ApiClient.config.instance_variable_set('@header', { 'key' => 'value' })
      end

      it 'should return a hash with the configured header' do
        ApiClient.config.header.should == { 'key' => 'value' }
      end
    end
  end

  describe '#header=' do
    before :each do
      ApiClient.configure do |config|
        config.header = { 'Content-Type' => 'application/xml' }
      end
    end

    it 'should merge content_type json with the given hash' do
      ApiClient.config.header.should == { 'Content-Type' => 'application/xml' }
    end
  end

  describe '#basic_auth=' do
    before :each do
      ApiClient.configure do |config|
        config.basic_auth('user', 'pass')
      end
    end

    after :each do
      ApiClient.configure do |config|
        config.header = {}
      end
    end

    it 'should merge basic_auth in header params' do
      ApiClient.config.header.should == { 'Content-Type' => 'application/xml',
                                          'Authorization' => 'Basic dXNlcjpwYXNz' }
    end
  end
end