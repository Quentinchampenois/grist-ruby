# frozen_string_literal: true

require "spec_helper"
require "byebug"

RSpec.describe Grist::Type::Organization do
  let(:subject) { described_class.new }
  let(:response) do
    [
      {
        "id" => 42,
        "name" => "Grist Labs",
        "domain" => "gristlabs",
        "owner" =>
          {
            "id" => 101,
            "name" => "Helga Hufflepuff",
            "picture" => "null"
          },
        "access" => "owners",
        "createdAt" => "2019-09-13T15:42:35.000Z",
        "updatedAt" => "2019-09-13T15:42:35.000Z"
      }
    ]
  end

  before do
    stub_request(:get, "http://localhost:8484/orgs").to_return(status: 200, body: response.to_json, headers: {})
  end

  describe "#all" do
    it "returns an array of organizations" do
      expect(described_class.all).to be_an(Array)
      expect(described_class.all.first).to be_a(Grist::Type::Organization)
      expect(described_class.all.first.id).to eq(42)
      expect(described_class.all.first.name).to eq("Grist Labs")
    end

    it "returns an empty array if the request fails" do
      stub_request(:get, "http://localhost:8484/orgs").to_return(status: 500)
      expect(described_class.all).to be_an(Array)
      expect(described_class.all).to be_empty
    end
  end

  describe "#find" do
    before do
      stub_request(:get, "http://localhost:8484/orgs/42").to_return(status: 200, body: response.first.to_json,
                                                                    headers: {})
    end

    it "returns an instance of Organization" do
      got = described_class.find(42)
      expect(got).to be_a(Grist::Type::Organization)
      expect(got.name).to eq("Grist Labs")
    end
  end

  describe "#update" do
    it "updates and returns a new instance of Organization" do
      stub_request(:get, "http://localhost:8484/orgs/42").to_return(status: 200, body: response.first.to_json,
                                                                                                                                  headers: {})
      stub_request(:patch, "http://localhost:8484/orgs/42").to_return(status: 200, body: response.first.merge("name" => "Grist Updated!").to_json)
      got = described_class.update(42, { name: "Grist Updated!" })
      expect(got).to be_a(Grist::Type::Organization)
      expect(got.name).to eq("Grist Updated!")
    end
  end
end
