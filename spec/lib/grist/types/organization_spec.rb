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
  let(:users) do
    [
      {
        "id" => 100,
        "name" => "Andrea",
        "email" => "andrea@example.org",
        "access" => "owners"
      }
    ]
  end

  before do
    stub_request(:get, "http://localhost:8484/api/orgs").to_return(status: 200, body: response.to_json, headers: {})
    stub_request(:get, "http://localhost:8484/api/orgs/42").to_return(status: 200, body: response.first.to_json,
                                                                      headers: {})
  end

  describe "#all" do
    it "returns an array of organizations" do
      expect(described_class.all).to be_an(Array)
      expect(described_class.all.first).to be_a(Grist::Type::Organization)
      expect(described_class.all.first.id).to eq(42)
      expect(described_class.all.first.name).to eq("Grist Labs")
    end

    it "returns an empty array if the request fails" do
      stub_request(:get, "http://localhost:8484/api/orgs").to_return(status: 500)
      expect(described_class.all).to be_an(Array)
      expect(described_class.all).to be_empty
    end
  end

  describe "#find" do
    before do
      stub_request(:get, "http://localhost:8484/api/orgs/42").to_return(status: 200, body: response.first.to_json,
                                                                        headers: {})
    end

    it "returns an instance of Organization" do
      got = described_class.find(42)
      expect(got).to be_a(Grist::Type::Organization)
      expect(got.name).to eq("Grist Labs")
    end
  end

  describe "#update" do
    let(:body) { response.first.merge("name" => "Grist Updated!") }
    it "updates and returns a new instance of Organization" do
      stub_request(:patch, "http://localhost:8484/api/orgs/42").to_return(status: 200,
                                                                          body: body.to_json)
      got = described_class.update(42, { name: "Grist Updated!" })
      expect(got).to be_a(Grist::Type::Organization)
      expect(got.name).to eq("Grist Updated!")
    end
  end

  describe "#delete" do
    before do
      stub_request(:delete, "http://localhost:8484/api/orgs/42").to_return(status: 200)
    end

    it "deletes an organization" do
      got = described_class.delete(42)
      expect(got).to be_a(Grist::Type::Organization)
      expect(got.deleted?).to be_truthy
    end
  end

  describe "#access" do
    before do
      stub_request(:get, "http://localhost:8484/api/orgs/42/access").to_return(status: 200,
                                                                               body: { "users" => users }.to_json)
    end

    it "returns the access of the organization" do
      got = described_class.access(42)
      expect(got).to be_a(Array)
      expect(got.first).to be_a(Grist::Type::Access)
      expect(got.first.name).to eq("Andrea")
    end
  end

  describe "#create_workspace" do
    let(:body) { "100" }
    before do
      stub_request(:post, "http://localhost:8484/api/orgs/42/workspaces").to_return(status: 200,
                                                                                    body: body)
    end

    it "creates a new workspace in the organization" do
      got = described_class.create_workspace(42, { name: "New workspace" })
      expect(got).to be_a(Grist::Type::Workspace)
      expect(got.id).to eq(100)
    end
  end

  describe "#list_workspaces" do
    let(:workspaces) do
      [
        {
          "id": 42,
          "name": "Secret Plans",
          "access": "owners",
          "docs": [
            {
              "id": 145,
              "name": "Project Lollipop",
              "access": "owners",
              "isPinned": true,
              "urlId": "null"
            }
          ],
          "orgDomain": "gristlabs"
        }
      ]
    end
    before do
      stub_request(:get, "http://localhost:8484/api/orgs/42/workspaces").to_return(status: 200,
                                                                                   body: workspaces.to_json)
    end

    it "returns an array of workspaces" do
      got = described_class.list_workspaces(42)
      expect(got).to be_an(Array)
      expect(got.first).to be_a(Grist::Type::Workspace)
      expect(got.first.id).to eq(42)
    end
  end

  describe "#workspaces_path" do
    it "returns the correct path" do
      org = described_class.new("id" => 42)
      expect(org.workspaces_path).to eq("/orgs/42/workspaces")
    end
  end
end
