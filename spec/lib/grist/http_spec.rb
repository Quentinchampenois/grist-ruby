require "spec_helper"

RSpec.describe Grist::HTTP do
  let(:dummy_class) { Class.new { extend Grist::HTTP } }
  let(:dummy_url) { "http://example.com/api" }

  before do
    allow_any_instance_of(Faraday::Connection).to receive(:send)
  end

  describe "#get" do
    it "sends a GET request" do
      expect(dummy_class).to receive(:request).with(method: :get, path: "/path")
      dummy_class.get("/path")
    end
  end

  describe "#post" do
    it "sends a POST request" do
      expect(dummy_class).to receive(:request).with(method: :post, path: "/path", payload: { key: "value" })
      dummy_class.post("/path", key: "value")
    end
  end

  describe "#put" do
    it "sends a PUT request" do
      expect(dummy_class).to receive(:request).with(method: :put, path: "/path", payload: { key: "value" })
      dummy_class.put("/path", key: "value")
    end
  end

  describe "#destroy" do
    it "sends a DELETE request" do
      expect(dummy_class).to receive(:request).with(method: :delete, path: "/path")
      dummy_class.destroy("/path")
    end
  end

  describe "#request" do
    let(:connection) { instance_double(Faraday::Connection) }

    before do
      allow(dummy_class).to receive(:connection).and_return(connection)
    end

    context "when request is successful" do
      it "sends the request with proper parameters" do
        expect(connection).to receive(:send).with(:get, "/path", nil, {})
        dummy_class.send(:request, method: :get, path: "/path")
      end
    end

    context "when request raises Faraday::Error" do
      before do
        allow(connection).to receive(:send).and_raise(Faraday::Error.new("error message",
                                                                         { status: 500, body: "error body" }))
      end

      it "rescues the error and outputs status and body" do
        expect { dummy_class.send(:request, method: :get, path: "/path") }.to output("500\nerror body\n").to_stdout
      end
    end
  end
end
