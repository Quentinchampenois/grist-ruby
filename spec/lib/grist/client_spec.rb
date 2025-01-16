require "spec_helper"

RSpec.describe Grist::Client do
  subject { described_class.new(api_key: api_key, url: base_url) }
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
  end
end