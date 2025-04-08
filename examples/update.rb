#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "grist"
require "byebug"

raise ArgumentError, "You must provide env var : 'GRIST_API_KEY'" if ENV.fetch("GRIST_API_KEY", "").empty?
raise ArgumentError, "You must provide env var : 'GRIST_API_URL'" if ENV.fetch("GRIST_API_URL", "").empty?

TABLE_NAME = "Open_source_software"

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

table = doc.tables.find { |t| t.id == TABLE_NAME }
if !table.nil?
  puts "Table found in doc #{doc.name}. Using the last one '#{table.id}'..."
  puts "Table ID: #{table.id}"
else
  puts "No tables found in doc #{doc.name}. Creating a new one..."
  new_table = Grist::Type::Table.new("id" => TABLE_NAME, "columns" => [
                                       { "id" => "name", "fields" => { "label" => "Software name" } },
                                       { "id" => "description", "fields" => { "label" => "Description" } },
                                       { "id" => "link", "fields" => { "label" => "Source code link" } }
                                     ])
  table = doc.create_tables("tables" => [new_table.to_hash])[0]
  puts "Table created ID: #{table&.id}"
end

# TODO: WIP
