module Grist
  module Endpoint
    module Workspace
      def workspaces(organization_id)
        get("/orgs/#{organization_id}/workspaces")
      end

      def create(organization_id, payload, **params)
        post("/orgs/#{organization_id}/workspaces", payload, params)
      end
      alias create_workspace create

      def list_users_with_access(id)
        get("/orgs/#{id}/access")
      end

      def manage_access(id, **params)
        patch("/orgs/#{id}/access", params)
      end
    end
  end
end
