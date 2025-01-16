require "spec_helper"

RSpec.describe Grist::Client do
  subject { described_class.new }

  describe "#initialize" do
    it "initializes with a default base_url" do
      expect(subject.base_url).to eq("https://api.getgrist.com")
    end

    it "initializes with a custom base_url" do
      client = described_class.new(url: "https://api.example.com")
      expect(client.base_url).to eq("https://api.example.com")
    end
  end
end