require 'spec_helper'

describe ApiClient::Configuration do
  describe "#path" do
    it "should be nil by default" do
      ApiClient.config.path.should be_nil
    end

    describe "when overwrited by configure" do
      before :each do
        ApiClient.configure do |config|
          config.path = "api.example.com"
        end
      end

      it "should not be nil" do
        ApiClient.config.path.should_not be_nil
      end
    end
  end
end
