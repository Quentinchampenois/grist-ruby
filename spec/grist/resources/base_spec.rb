require 'spec_helper'

RSpec.describe Grist::Resources::Base do
  let(:client) { double('client') }
  let(:resource) { described_class.new(client, 'orgs') }

  it 'lists resources' do
    allow(client).to receive(:request).with(:get, 'orgs', {}).and_return([{ id: 1 }])
    expect(resource.list).to eq([{ id: 1 }])
  end

  it 'finds a resource' do
    allow(client).to receive(:request).with(:get, 'orgs/1').and_return({ id: 1 })
    expect(resource.get(1)).to eq({ id: 1 })
  end

  it 'creates a resource' do
    allow(client).to receive(:request).with(:post, 'orgs', { name: 'New Org' }).and_return({ id: 1, name: 'New Org' })
    expect(resource.create(name: 'New Org')).to eq({ id: 1, name: 'New Org' })
  end

  it 'updates a resource' do
    allow(client).to receive(:request).with(:put, 'orgs/1', { name: 'Updated Org' }).and_return({ id: 1, name: 'Updated Org' })
    expect(resource.update(1, name: 'Updated Org')).to eq({ id: 1, name: 'Updated Org' })
  end

  it 'deletes a resource' do
    allow(client).to receive(:request).with(:delete, 'orgs/1').and_return({ success: true })
    expect(resource.delete(1)).to eq({ success: true })
  end
end
