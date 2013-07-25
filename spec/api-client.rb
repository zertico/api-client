require 'spec_helper'

describe ApiClient do
  context 'default settings' do
    it 'should have a blank path' do
      ApiClient.config.path.should == ''
    end

    it 'should have an empty header' do
      ApiClient.config.header.should == {}
    end

    it 'should have mock equal false' do
      ApiClient.config.mock.should be_false
    end
  end
end