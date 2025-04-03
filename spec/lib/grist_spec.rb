# frozen_string_literal: true

# spec/grist_spec.rb

require "rspec"

RSpec.describe Grist do
  describe "#api_key" do
    it "returns the GRIST_API_KEY from environment variables" do
      allow(ENV).to receive(:[]).with("GRIST_API_KEY").and_return("test_api_key")
      expect(Grist.api_key).to eq("test_api_key")
    end
  end

  describe "#token_auth" do
    it "returns the Bearer token with the API key" do
      allow(Grist).to receive(:api_key).and_return("test_api_key")
      expect(Grist.token_auth).to eq("Bearer test_api_key")
    end
  end

  describe "#base_api_url" do
    it "returns the base API URL from environment variables" do
      allow(ENV).to receive(:[]).with("GRIST_API_URL").and_return("https://api.grist.com/")
      expect(Grist.base_api_url).to eq("https://api.grist.com")
    end

    it "removes trailing slash from the base API URL" do
      allow(ENV).to receive(:[]).with("GRIST_API_URL").and_return("https://api.grist.com/")
      expect(Grist.base_api_url).to eq("https://api.grist.com")
    end

    it "returns nil if GRIST_API_URL is not set" do
      allow(ENV).to receive(:[]).with("GRIST_API_URL").and_return(nil)
      expect(Grist.base_api_url).to be_nil
    end
  end

  describe "#localhost?" do
    it "returns true if base_api_url includes localhost" do
      allow(Grist).to receive(:base_api_url).and_return("http://localhost:3000")
      expect(Grist.localhost?).to be true
    end

    it "returns false if base_api_url does not include localhost" do
      allow(Grist).to receive(:base_api_url).and_return("https://api.grist.com")
      expect(Grist.localhost?).to be false
    end
  end

  describe "custom errors" do
    it "defines Error as a subclass of StandardError" do
      expect(Grist::Error.ancestors).to include(StandardError)
    end

    it "defines APIError as a subclass of Grist::Error" do
      expect(Grist::APIError.ancestors).to include(Grist::Error)
    end

    it "defines InvalidAPIKey as a subclass of APIError" do
      expect(Grist::InvalidApiKey.ancestors).to include(Grist::APIError)
    end
  end
end
