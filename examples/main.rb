#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "grist"
require "byebug"

raise ArgumentError, "You must provide env var : 'GRIST_API_KEY'" if ENV.fetch("GRIST_API_KEY", "").empty?
raise ArgumentError, "You must provide env var : 'GRIST_API_URL'" if ENV.fetch("GRIST_API_URL", "").empty?

orgs = Grist::Type::Organization.all
org = orgs.last

if org.nil?
   puts "No organization present"
   exit 0
end

puts "Org: #{org.name} - ID: #{org.id}"

ws_name = "Workspace N°#{rand(1_000)}"
puts "Creating workspace #{ws_name}..."
ws = org.create_workspace({ name: ws_name })

puts "Creating document 'demo' into workspace '#{ws_name}'..."
doc = ws.create_doc({
                      name: "Demo",
                      isPinned: true
                    })

puts "Creating document 'Github' into workspace '#{ws_name}'"
ws.create_doc({
                name: "Github",
                isPinned: false
              })

puts "Creating tables for document 'demo' into workspace '#{ws_name}'..."
doc.create_tables({
                    "tables" => [
                      { "id" => "Community gems",
                        "columns" => [
                          { "id" => "name", "fields" => { "label" => "Gem name" } },
                          { "id" => "description", "fields" => { "label" => "Description" } },
                          { "id" => "link", "fields" => { "label" => "RubyGems link" } }
                        ] }
                    ]
                  })

puts "Creating tables for document 'demo' into workspace '#{ws_name}'..."
doc.create_tables({
                    "tables" => [
                      { "id" => "Standard library",
                        "columns" => [
                          { "id" => "name", "fields" => { "label" => "Library name" } },
                          { "id" => "url", "fields" => { "label" => "Source code public URL" } },
                          { "id" => "version", "fields" => { "label" => "Latest version" } }
                        ] }
                    ]
                  })

doc = ws.docs.first
tables = doc.tables

puts "Tables:"
tables.each do |table|
  puts table.id
  puts "Total records : #{table.records.count}"
end

table = tables.last

puts "Creating records into table from doc 'demo' into workspace '#{ws_name}'..."
table.create_records("records" => [
                       {
                         "fields" => {
                           "name" => "did_you_mean",
                           "url" => "https://github.com/ruby/did_you_mean",
                           "version" => "v2.0.0"
                         }
                       }
                     ])

puts "Terminated, go check at http://localhost:8484/o/demo"
