# frozen_string_literal: true

module Grist
  module Endpoint
    module Workspace
      def workspaces(organization_id)
        get("/orgs/#{organization_id}/workspaces")
      end

      def workspace(id)
        get("/workspaces/#{id}")
      end

      def create_workspace(organization_id, payload, **params)
        post("/orgs/#{organization_id}/workspaces", payload, params)
      end

      def update(id, payload, **params)
        patch("/workspaces/#{id}", payload, params)
      end
      alias update_workspace update

      def delete(id)
        destroy("/workspaces/#{id}")
      end
      alias delete_workspace delete

      def list_workspace_users(id)
        get("/workspaces/#{id}/access")
      end

      def manage_workspace_access(id, payload, **params)
        patch("/workspaces/#{id}/access", payload, params)
      end
    end
  end
end
