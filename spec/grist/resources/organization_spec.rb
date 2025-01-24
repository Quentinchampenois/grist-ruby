require 'spec_helper'
require 'grist/resources/organization'

RSpec.describe Grist::Resources::Organization do
  let(:client) { double('client') }
  let(:org) { described_class.new(client) }

  it 'lists organizations' do
    allow(client).to receive(:request).with(:get, 'orgs', {}).and_return([{ id: 1, name: 'Org 1' }])
    expect(org.list).to eq([{ id: 1, name: 'Org 1' }])
  end

  it 'finds an organization' do
    allow(client).to receive(:request).with(:get, 'orgs/1').and_return({ id: 1, name: 'Org 1' })
    expect(org.get(1)).to eq({ id: 1, name: 'Org 1' })
  end

  it 'updates an organization' do
    allow(client).to receive(:request).with(:put, 'orgs/1', { name: 'Updated Org' }).and_return({ id: 1, name: 'Updated Org' })
    expect(org.update(1, name: 'Updated Org')).to eq({ id: 1, name: 'Updated Org' })
  end

  it 'deletes an organization' do
    allow(client).to receive(:request).with(:delete, 'orgs/1').and_return({ success: true })
    expect(org.delete(1)).to eq({ success: true })
  end

  it 'retrieves organization access' do
    allow(client).to receive(:request).with(:get, 'orgs/1/access').and_return({ access: 'read' })
    expect(org.access(1)).to eq({ access: 'read' })
  end

  it 'updates organization access' do
    allow(client).to receive(:request).with(:put, 'orgs/1/access', { role: 'admin' }).and_return({ success: true })
    expect(org.update_access(1, role: 'admin')).to eq({ success: true })
  end

  it 'retrieves organization workspaces' do
    allow(client).to receive(:request).with(:get, 'orgs/1/workspaces').and_return([{ id: 10, name: 'Workspace 1' }])
    expect(org.workspaces(1)).to eq([{ id: 10, name: 'Workspace 1' }])
  end
end
