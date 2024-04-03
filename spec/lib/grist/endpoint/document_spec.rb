# frozen_string_literal: true

require "spec_helper"

RSpec.describe Grist::Endpoint::Document do
  subject { grist_client }

  let(:workspace_id) { 42 }
  let(:document_id) { 10 }
  let(:body) { { name: "Document name", isPinned: false } }
  let(:grist_client) { Grist::Client.new }

  describe "#create_document" do
    it "calls the post method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:post).with("/workspaces/42/docs", body, {})
      subject.create_document(workspace_id, body)
    end
  end

  describe "#describe_document" do
    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/docs/10")
      subject.describe_document(document_id)
    end
  end

  describe "#download_document" do
    let(:query_params) { nil }

    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/docs/10/download", {:query_params=>nil})
      subject.download_document(document_id, nil)
    end

    context "when query_params are provided" do
      let(:query_params) { { format: "csv" } }

      it "calls the get method with the correct path" do
        expect_any_instance_of(Grist::HTTP).to receive(:get).with("/docs/10/download", {query_params: { format: "csv" }})
        subject.download_document(document_id, query_params)
      end
    end
  end

  describe "#list_users_document" do
    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/docs/10/access")
      subject.list_users_document(document_id)
    end
  end

  describe "#update_metadata_document" do
    it "calls the patch method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:patch).with("/docs/10", body, {})
      subject.update_metadata_document(document_id, body)
    end
  end

  describe "#move_document" do
    it "calls the patch method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:patch).with("/docs/10/move", { workspace: workspace_id }, {})
      subject.move_document(document_id, workspace_id)
    end
  end

  describe "#manage_access_document" do
    it "calls the patch method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:patch).with("/docs/10/access", body, {})
      subject.manage_access_document(document_id, body)
    end
  end

  describe "#delete_document" do
    it "calls the post method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:destroy).with("/docs/10")
      subject.delete_document(document_id)
    end
  end
end
