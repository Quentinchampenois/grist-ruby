#!/usr/bin/env ruby

require "bundler/setup"
require 'grist'

api = Grist::API.new(api_key: ENV["GRIST_API_KEY"], base_url: ENV["GRIST_API_URL"])

# Fetch all organizations
organizations = api.organizations.list[:data]

org_id = organizations.first['id']
# Find a specific organization
puts api.organizations.get(org_id)

# Update an organization
api.organizations.update(org_id, { name: 'Updated Org Name' })

# Delete an organization
# api.organizations.delete(org_id)

# List workspaces in an organization
workspace = api.organizations.workspaces(org_id)

# Create a new workspace
api.organizations.create_workspace(org_id, { name: 'New Workspace' })

# Fetch all documents
doc_id = workspace[:data].first["docs"].first["id"]

# Download document as SQL
puts api.documents.download_sql(doc_id)

# Move document to another workspace
# api.documents.move('docId', { workspaceId: 'newWorkspaceId' })