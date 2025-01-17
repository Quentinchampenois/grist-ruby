require 'spec_helper'

RSpec.describe Grist::Resource do
  subject { described_class.new(client, resource_name) }

  let(:client) { Grist::Client.new(api_key: api_key, url: url) }
  let(:api_key) { "1234" }
  let(:url) { "https://api.example.com" }

  let(:resource_name) { "orgs" }

  describe "#initialize" do
    it "initializes with a client and resource_name" do
      expect(subject.client).to eq(client)
      expect(subject.resource_name).to eq(resource_name)
    end
  end

  describe "#all" do
    it "calls client.request with :get and resource_name" do
      expect(client).to receive(:request).with(:get, resource_name, {})
      subject.all
    end

    it "calls client.request with :get and resource_name and params" do
      expect(client).to receive(:request).with(:get, resource_name, { page: 1 })
      subject.all(page: 1)
    end
  end

  describe "#find" do
    it "calls client.request with :get and resource_name and id" do
      expect(client).to receive(:request).with(:get, "#{resource_name}/1")
      subject.find(1)
    end
  end

  describe "#create" do
    it "calls client.request with :post and resource_name and attrs" do
      expect(client).to receive(:request).with(:post, resource_name, { name: "Test" })
      subject.create(name: "Test")
    end
  end

  describe "#update" do
    it "calls client.request with :put and resource_name and id and attrs" do
      expect(client).to receive(:request).with(:put, "#{resource_name}/1", { name: "Test" })
      subject.update(1, name: "Test")
    end
  end

  describe "#delete" do
    it "calls client.request with :delete and resource_name and id" do
      expect(client).to receive(:request).with(:delete, "#{resource_name}/1")
      subject.delete(1)
    end
  end

  describe "#sub_resource" do
    it "creates a sub resource with sub_path" do
      sub_res = subject.sub_resource("example")
      expect(sub_res.resource_name).to eq("orgs/example")
    end
  end
end