# frozen_string_literal: true

module Grist
  module Resources
    class Organization < Base
      def initialize(client)
        super(client, "orgs")
      end

      def access(org_id)
        client.request(:get, "orgs/#{org_id}/access")
      end

      def update_access(org_id, data)
        client.request(:put, "orgs/#{org_id}/access", data)
      end

      def workspaces(org_id)
        client.request(:get, "orgs/#{org_id}/workspaces")
      end

      def create_workspace(org_id, data)
        client.request(:post, "orgs/#{org_id}/workspaces", data)
      end
    end
  end
end
