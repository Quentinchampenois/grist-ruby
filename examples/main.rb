#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "grist"
require "byebug"

raise ArgumentError, "You must provide env var : 'GRIST_API_KEY'" if ENV.fetch("GRIST_API_KEY", "").empty?
raise ArgumentError, "You must provide env var : 'GRIST_API_URL'" if ENV.fetch("GRIST_API_URL", "").empty?

orgs = Grist::Type::Organization.all
org = orgs.last
puts "Org: #{org.name} - ID: #{org.id}"
ws = org.create_workspace({ name: "Workspace N°#{rand(1_000)}" })
doc = ws.create_doc({
                      name: "Decidim",
                      isPinned: true
                    })
ws.create_doc({
                name: "Github",
                isPinned: false
              })

doc.create_tables({
                    "tables" => [
                      { "id" => "Community modules",
                        "columns" => [
                          { "id" => "name", "fields" => { "label" => "Module name" } },
                          { "id" => "description", "fields" => { "label" => "Description" } },
                          { "id" => "version", "fields" => { "label" => "Decidim version" } }
                        ] }
                    ]
                  })

doc.create_tables({
                    "tables" => [
                      { "id" => "Instances",
                        "columns" => [
                          { "id" => "name", "fields" => { "label" => "Decidim name" } },
                          { "id" => "url", "fields" => { "label" => "Public URL" } },
                          { "id" => "version", "fields" => { "label" => "Decidim version" } }
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
table.create_records("records" => [
                       {
                         "fields" => {
                           "name" => "Decidim Barcelona",
                           "url" => "https://decidim.barcelona",
                           "version" => "0.29.2"
                         }
                       }
                     ])

puts "Ending."
