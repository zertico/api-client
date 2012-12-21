require 'spec_helper'

describe ApiClient::Configuration do
  describe "#url_path" do
    it "should be nil by default" do
      ApiClient.config.url_path.should be_nil
    end

    describe "when overwrited by configure" do
      before :each do
        ApiClient.configure do |config|
          config.url_path = "api.example.com"
        end
      end

      it "should not be nil" do
        ApiClient.config.url_path.should_not be_nil
      end
    end
  end
end
