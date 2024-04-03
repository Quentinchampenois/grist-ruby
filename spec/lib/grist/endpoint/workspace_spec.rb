# frozen_string_literal: true

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

  describe "#create_workspace" do
    it "calls the post method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:post).with("/orgs/42/workspaces", { name: "My Workspace" }, {})
      subject.create_workspace(organization_id, { name: "My Workspace" })
    end
  end

  describe "#workspace" do
    it "calls the post method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/workspaces/10")
      subject.workspace(10)
    end
  end

  describe "#update_workspace" do
    it "calls the post method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:patch).with("/workspaces/10", { name: "My Workspace" }, {})
      subject.update_workspace(10, { name: "My Workspace" })
    end
  end

  describe "#delete_workspace" do
    it "calls the post method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:destroy).with("/workspaces/10")
      subject.delete_workspace(10)
    end
  end

  describe "#list_workspace_users" do
    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/workspaces/10/access")
      subject.list_workspace_users(10)
    end
  end

  describe "#manage_workspace_access" do
    let(:id) { 42 }
    let(:body) do
      { "delta" => {
        "users" => [
          "owner@example.org" => "owner",

          "viewer@example.org" => "viewer"
        ]
      } }
    end

    it "calls the patch method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:patch).with("/workspaces/42/access", body, {})

      subject.manage_workspace_access(42, body)
    end
  end
end
