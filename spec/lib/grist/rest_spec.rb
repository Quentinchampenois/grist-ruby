# frozen_string_literal: true

# spec/grist/rest_spec.rb

require "rspec"
require "net/http"
require "json"

RSpec.describe Grist::Rest do
  let(:subject) { klass.new }
  let(:klass) do
    Class.new do
      include Grist::Rest

      PATH = "/test_path"
    end
  end
  let(:base_api_url) { "http://localhost:3000" }
  let(:api_key) { "test_api_key" }
  let(:endpoint) { "/api" }
  let(:params) { { key: "value" } }
  let(:http_request) do
    instance_double(Net::HTTP, request: response, "use_ssl=" => false)
  end
  let(:response_body) { { success: true }.to_json }
  let(:response) { instance_double(Net::HTTPResponse, body: response_body, code: 200) }

  before do
    allow(Grist).to receive(:base_api_url).and_return(base_api_url)
    allow(Grist).to receive(:token_auth).and_return("Bearer #{api_key}")
    allow(subject).to receive(:path).and_return(endpoint)
  end

  describe "#request" do
    it "sends a GET request with query parameters" do
      allow(Net::HTTP).to receive(:new).and_return(http_request)
      allow_any_instance_of(Net::HTTP).to receive(:use_ssl=)

      result = subject.request(:get, endpoint, params)

      expect(result).to be_a(Grist::Response)
      expect(result.data).to eq(JSON.parse(response_body))
      expect(result.code).to eq(200)
    end

    it "sends a POST request with JSON body" do
      allow(Net::HTTP).to receive(:new).and_return(http_request)
      allow_any_instance_of(Net::HTTP).to receive(:use_ssl=)

      result = subject.request(:post, endpoint, params)

      expect(result).to be_a(Grist::Response)
      expect(result.data).to eq(JSON.parse(response_body))
      expect(result.code).to eq(200)
    end
  end
end
