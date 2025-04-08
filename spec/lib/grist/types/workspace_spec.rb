# frozen_string_literal: true

require "spec_helper"
require "byebug"

RSpec.describe Grist::Type::Workspace do
  let(:subject) { described_class.new("id" => id) }
  let(:response) do
    [
      {
        "id" => org_id,
        "name" => "Grist Labs",
        "orgDomain" => "gristlabs",
        "isSupportWorkspace" => false,
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
  let(:id) { 10 }
  let(:org_id) { 42 }

  before do
    stub_request(:get, "http://localhost:8484/orgs/42").to_return(status: 200, body: response.first.to_json,
                                                                  headers: {})
    stub_request(:get, "http://localhost:8484/api/workspaces").to_return(status: 200, body: response.to_json,
                                                                         headers: {})
  end

  describe "#all" do
    it "returns an array of workspaces" do
      got = described_class.all(id)
      expect(got).to be_an(Array)
      expect(got.first).to be_a(Grist::Type::Workspace)
      expect(got.first.id).to eq(42)
      expect(got.first.name).to eq("Grist Labs")
    end
  end

  describe "#find" do
    before do
      stub_request(:get, "http://localhost:8484/api/workspaces/42").to_return(status: 200, body: response.first.to_json,
                                                                              headers: {})
    end

    it "returns an instance of Workspace" do
      got = described_class.find(42)
      expect(got).to be_a(Grist::Type::Workspace)
      expect(got.name).to eq("Grist Labs")
    end
  end

  describe "#create" do
    let(:body) { response.first.merge("name" => "Grist Created!") }

    before do
      %w[get patch].each do |method|
        stub_request(method.to_sym, "http://localhost:8484/api/workspaces/42").to_return(status: 200,
                                                                                         body: body.to_json)
      end
    end
    it "creates and returns a new instance of Workspace" do
      got = described_class.update(42, { name: "Grist Created!" })
      expect(got).to be_a(Grist::Type::Workspace)
      expect(got.name).to eq("Grist Created!")
    end
  end

  describe "#update" do
    let(:body) { response.first.merge("name" => "Grist Updated!") }

    before do
      %w[get patch].each do |method|
        stub_request(method.to_sym, "http://localhost:8484/api/workspaces/42").to_return(status: 200,
                                                                                         body: body.to_json)
      end
    end
    it "updates and returns a new instance of Workspace" do
      got = described_class.update(42, { name: "Grist Updated!" })
      expect(got).to be_a(Grist::Type::Workspace)
      expect(got.name).to eq("Grist Updated!")
    end
  end

  describe "#delete" do
    before do
      stub_request(:get, "http://localhost:8484/api/workspaces/42").to_return(status: 200)
      stub_request(:delete, "http://localhost:8484/api/workspaces/").to_return(status: 200)
    end

    it "deletes a Workspace" do
      got = described_class.delete(42)
      expect(got).to be_a(Grist::Type::Workspace)
      expect(got.deleted?).to be_truthy
    end
  end

  describe "#create_doc" do
    let(:doc_response) do
      {
        "id" => 100,
        "name" => "New Doc",
        "createdAt" => "2023-10-01T00:00:00.000Z",
        "updatedAt" => "2023-10-01T00:00:00.000Z"
      }
    end

    before do
      stub_request(:post, "http://localhost:8484/api/workspaces/#{id}/docs").to_return(status: 200,
                                                                                       body: doc_response.to_json)
    end

    it "creates a new doc in the workspace" do
      got = subject.create_doc({ name: "New Doc" })
      expect(got).to be_a(Grist::Type::Doc)
      expect(got.name).to eq("New Doc")
    end

    it "uses create_doc_path to create a new doc" do
      got = subject.send(:create_doc_path)
      expect(got).to eq("/workspaces/#{id}/docs")
    end
  end
end
