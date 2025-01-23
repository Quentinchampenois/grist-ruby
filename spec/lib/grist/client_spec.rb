require 'spec_helper'
require 'grist/client'
require 'webmock/rspec'

RSpec.describe Grist::Client do
  let(:api_key) { 'test_api_key' }
  let(:base_url) { 'https://example.org' }
  let(:client) { described_class.new(api_key: api_key, base_url: base_url) }

  before do
    stub_request(:any, /example.org/).to_return(status: 200, body: '{}', headers: { 'Content-Type' => 'application/json' })
  end

  describe '#request' do
    it 'performs a GET request' do
      response = client.request(:get, 'orgs')
      expect(response).to be_a(Grist::Response)
      expect(response.data).to eq({})
      expect(response.error).to be_nil
      expect(WebMock).to have_requested(:get, "https://example.org/api/orgs")
    end

    it 'performs a POST request with data' do
      response = client.request(:post, 'orgs', { name: 'New Org' })
      expect(response).to be_a(Grist::Response)
      expect(response.data).to eq({})
      expect(response.error).to be_nil
      expect(WebMock).to have_requested(:post, "https://example.org/api/orgs").with(body: { name: 'New Org' })
    end
  end
end
