#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require "grist"
require "byebug"

class Organization
  def initialize(client, path)
    @client = client
    @path = path
  end

  def self.list(params = {})
    client.request(:get, "/orgs", params)
  end
end

raise ArgumentError, "You must provide env var : 'GRIST_API_KEY'" if ENV.fetch("GRIST_API_KEY", "").empty?
raise ArgumentError, "You must provide env var : 'GRIST_API_URL'" if ENV.fetch("GRIST_API_URL", "").empty?

Grist::API.new(api_key: ENV["GRIST_API_KEY"], base_url: ENV["GRIST_API_URL"])

orgs = Grist::Types::Organization.all
org = Grist::Types::Organization.update(orgs.last.id, { name: "Hello #{rand(1_000)}" })
puts org.name

org.create_workspace({ name: "Hello WS #{rand(1_000)}" })

Grist::Types::Organization.access(orgs.last.id)
Grist::Types::Workspace.create(orgs.last.id, { name: "Hello WS #{rand(1_000)}" })
wss = Grist::Types::Organization.list_workspaces(orgs.first.id)
puts wss.first.docs

ws = wss.first
puts ws.name

doc = ws.create_doc({
                      name: "Hello Doc #{rand(1_000)}",
                      isPinned: rand(0..1) == 1
                    })

docs = ws.docs
puts doc&.name
puts doc&.id
puts "Listing tables"

doc_tables = docs.last.tables
puts doc_tables.inspect

puts "Ending."
