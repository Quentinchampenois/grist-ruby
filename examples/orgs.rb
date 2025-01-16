#!/usr/bin/env ruby

require "bundler/setup"
require 'grist'

client = Grist::Client.new(api_key: ENV["GRIST_API_KEY"], url: ENV["GRIST_API_URL"])
resource = Grist::Resource.new(client, "orgs")

orgs = resource.all
puts "Found #{orgs.count} organizations !"
puts "First organization: #{orgs.first["name"]} owned by #{orgs.first["owner"]["name"]} !"
puts resource.find(orgs.first["id"])