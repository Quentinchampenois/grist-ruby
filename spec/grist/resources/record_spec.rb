require 'spec_helper'
require 'webmock/rspec'

RSpec.describe Grist::Resources::Record do
  let(:api_key) { 'test_api_key' }
  let(:base_url) { 'https://example.org' }
  let(:client) { Grist::Client.new(api_key: api_key, base_url: base_url) }
  let(:record_resource) { described_class.new(client) }
  let(:doc_id) { '12345' }
  let(:table_id) { 'test_table' }

  before do
    stub_request(:get, "#{base_url}/api/docs/12345/tables/test_table/records").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer test_api_key',
          'Content-Type'=>'application/json',
          'Host'=>'example.org',
          'User-Agent'=>'Ruby'
        }).to_return(status: 200, body: '[{"id": 1, "name": "Record 1"}]', headers: { 'Content-Type' => 'application/json' })
  end

  describe '#all' do
    it 'fetches all records for a table' do
      response = record_resource.all(doc_id, table_id)
      expect(response.success?).to be true
      expect(response.data).to be_an(Array)
      expect(response.data.first['id']).to eq(1)
    end
  end

  describe '#create' do
    let(:records) { [{ fields: { pet: "cat", popularity: 67} }, { fields: { pet: "dog", popularity: 95} }] }
    it 'creates a new record in the table' do
      stub_request(:post, "#{base_url}/api/docs/#{doc_id}/tables/#{table_id}/records")
        .with(body: { records: records }.to_json)
        .to_return(status: 201, body: '{"id": 2}', headers: { 'Content-Type' => 'application/json' })

      response = record_resource.create(doc_id, table_id, records)

      expect(response.success?).to be true
      expect(response.data['id']).to eq(2)
    end
  end

  describe '#update' do
    let(:records) { [{ id: 1, fields: { pet: "cat", popularity: 67}}, { id: 2, fields: { pet: "dog", popularity: 95}}] }

    it 'updates an existing record in the table' do
      stub_request(:patch, "#{base_url}/api/docs/#{doc_id}/tables/#{table_id}/records")
        .with(body: { records: records }.to_json)
        .to_return(status: 200, body: '{"id": 1, "name": "Updated Record"}', headers: { 'Content-Type' => 'application/json' })

      response = record_resource.update(doc_id, table_id, records)

      expect(response.success?).to be true
      expect(response.data['name']).to eq('Updated Record')
    end
  end

  describe '#delete' do
    it 'deletes a record from the table' do
      stub_request(:delete, "#{base_url}/api/docs/#{doc_id}/tables/#{table_id}/data/delete")
        .with(body: { ids: [1] }.to_json)
        .to_return(status: 200, body: '{"deleted": 1}', headers: { 'Content-Type' => 'application/json' })

      response = record_resource.delete(doc_id, table_id, [1])

      expect(response.success?).to be true
      expect(response.data['deleted']).to eq(1)
    end
  end
end
