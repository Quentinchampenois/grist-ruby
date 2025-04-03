#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "grist"

raise ArgumentError, "You must provide env var : 'GRIST_API_KEY'" if ENV.fetch("GRIST_API_KEY", "").empty?
raise ArgumentError, "You must provide env var : 'GRIST_API_URL'" if ENV.fetch("GRIST_API_URL", "").empty?

api = Grist::API.new(api_key: ENV["GRIST_API_KEY"], base_url: ENV["GRIST_API_URL"])

# Fetch all organizations
organizations = api.organizations.list

# List organization names
raise organizations.error unless organizations.success?

organizations.data.each do |org|
  puts org["name"]
end

# Create a new organization
new_org = api.organizations.create({ name: "GRIST CLI DASHBOARD" })
# Reload organizations
organizations = api.organizations.list.data if new_org.success?
org_id = organizations.first["id"]
# Find a specific organization
puts api.organizations.get(org_id)

# Update an organization
api.organizations.update(org_id, { name: "GRIST DASHBOARD UPDATED" })

# Delete an organization
# api.organizations.delete(org_id)

# List workspaces in an organization
# workspace = api.organizations.workspaces(org_id)
#
# Create a new workspace
workspace = api.organizations.create_workspace(org_id, { name: "GRIST WORKSPACE" })
ws_id = workspace.data if workspace.success?
puts "Workspace ID 'ws_id' created ! "
# Fetch all documents

doc = api.documents.create({ workspaceId: ws_id, name: "Grist new Document" })

# Download document as SQL
puts api.documents.download_sql(doc.data).data

# Move document to another workspace
# api.documents.move('docId', { workspaceId: 'newWorkspaceId' })
