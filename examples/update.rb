#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "grist"
require "byebug"

raise ArgumentError, "You must provide env var : 'GRIST_API_KEY'" if ENV.fetch("GRIST_API_KEY", "").empty?
raise ArgumentError, "You must provide env var : 'GRIST_API_URL'" if ENV.fetch("GRIST_API_URL", "").empty?

org_name = ENV.fetch("GRIST_ORG_NAME", "")
orgs = Grist::Type::Organization.all
org = orgs.find { |org| org.name == org_name }

if org&.workspaces&.empty?
  puts "No workspaces found in organization #{org.name}. Creating a new one..."
  ws = org.create_workspace({ name: "Grist Ruby" })
  puts "Workspace created: #{ws.name} - ID: #{ws.id}"
else
  ws = org&.workspaces&.last
  puts "Workspaces found in organization #{org.name}. Using the last one '#{ws.name}'..."
end

puts "Workspace ID: #{ws.id}"
puts "Workspace Name: #{ws.name}"

if ws.docs.empty?
  puts "No docs found in workspace #{ws.name}. Creating a new one..."
  doc = ws.create_doc({ name: "Getting started" })
  puts "Doc created: #{doc.name} - ID: #{doc.id}"
else
  doc = ws.docs.last
  puts "Docs found in workspace #{ws.name}. Using the last one '#{doc.name}'..."
end

puts "Doc ID: #{doc.id}"
puts "Doc Name: #{doc.name}"

if doc.tables.empty?
  puts "No tables found in doc #{doc.name}. Creating a new one..."
  table = doc.create_tables({ name: "Open source software" })
  puts "Table created ID: #{table.id}"
else
  table = doc.tables.last
  puts "Tables found in doc #{doc.name}. Using the last one '#{table.id}'..."
end

# TODO: WIP

exit 0
