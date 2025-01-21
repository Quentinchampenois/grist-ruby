#!/usr/bin/env ruby

require "bundler/setup"
require 'grist'

client = Grist::Client.new(api_key: ENV["GRIST_API_KEY"], url: ENV["GRIST_API_URL"])
grist_orgs = Grist::Resource.new(client, "orgs")

orgs = grist_orgs.all

if orgs.error?
  puts "Error: #{orgs.error}"
  return
end

return if orgs.results.empty?
puts "Found #{orgs.results&.count} organizations !"

puts "First organization: #{orgs.results.first["name"]} owned by #{orgs.results.first["owner"]["name"]} !"
puts grist_orgs.find(orgs.results.first["id"])

id = orgs.results.first["id"]
orgs_access = grist_orgs.sub_resource(id,"access")

orgs_access.all.results["users"].map do |user|
  puts "#{user["email"]} is authorized to access the organization #{orgs.results.first["name"]} !"
end
