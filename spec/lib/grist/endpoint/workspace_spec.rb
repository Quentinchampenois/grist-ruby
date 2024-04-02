require "spec_helper"

RSpec.describe Grist::Endpoint::Workspace do
  subject { grist_client }

  let(:organization_id) { 42 }
  let(:grist_client) { Grist::Client.new }

  describe "#workspaces" do
    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs/42/workspaces")
      subject.workspaces(organization_id)
    end
  end

  describe "#create" do
    it "calls the post method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:post).with("/orgs/42/workspaces", name: "My Workspace")
      subject.create(organization_id, { name: "My Workspace" })
    end
  end
end
