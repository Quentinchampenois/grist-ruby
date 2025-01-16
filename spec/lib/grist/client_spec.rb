require "spec_helper"

RSpec.describe Grist::Client do
  subject { described_class.new(url: base_url, api_key: api_key) }
  let(:base_url) { "https://api.example.com" }
  let(:api_key) { "1234" }

  describe "#initialize" do
    it "initializes with a base_url and api_key" do
      expect(subject.base_url).to eq("https://api.example.com")
      expect(subject.api_key).to eq("1234")
    end

    context "when base_url is not defined" do
      let(:base_url) { nil }
      it "initializes with a default base_url" do
        expect(subject.base_url).to eq("https://api.getgrist.com")
      end
    end

    context "when api_key is not defined" do
      let(:api_key) { nil }

      it "raises an MissingApiKey error" do
        expect { subject.api_key }.to raise_error(Grist::MissingApiKey)
      end
    end
  end
end