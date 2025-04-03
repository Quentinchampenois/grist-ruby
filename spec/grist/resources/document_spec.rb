# frozen_string_literal: true

require "spec_helper"
require "grist/resources/document"

RSpec.describe Grist::Resources::Document do
  let(:client) { double("client") }
  let(:document) { described_class.new(client) }

  it "finds a document" do
    allow(client).to receive(:request).with(:get, "docs/1").and_return({ id: 1, name: "Doc 1" })
    expect(document.get(1)).to eq({ id: 1, name: "Doc 1" })
  end

  it "updates a document" do
    allow(client).to receive(:request).with(:put, "docs/1",
                                            { name: "Updated Doc" }).and_return({ id: 1, name: "Updated Doc" })
    expect(document.update(1, name: "Updated Doc")).to eq({ id: 1, name: "Updated Doc" })
  end

  it "deletes a document" do
    allow(client).to receive(:request).with(:delete, "docs/1").and_return({ success: true })
    expect(document.delete(1)).to eq({ success: true })
  end

  it "downloads a document as SQL" do
    allow(client).to receive(:request).with(:get, "docs/1/download").and_return("SQL Dump Content")
    expect(document.download_sql(1)).to eq("SQL Dump Content")
  end

  it "moves a document to another workspace" do
    allow(client).to receive(:request).with(:post, "docs/1/move", { workspaceId: "2" }).and_return({ success: true })
    expect(document.move(1, workspaceId: "2")).to eq({ success: true })
  end

  it "forces reload of a document" do
    allow(client).to receive(:request).with(:post, "docs/1/force-reload").and_return({ success: true })
    expect(document.force_reload(1)).to eq({ success: true })
  end
end
