module Grist
  module Endpoint
    module Organization
      def list
        get("/orgs")
      end

      def find(id)
        get("/orgs/#{id}")
      end

      def update(id, **params)
        patch("/orgs/#{id}", params)
      end

      def list_users_with_access(id)
        get("/orgs/#{id}/access")
      end

      def manage_access(id, **params)
        patch("/orgs/#{id}/access", params)
      end
    end
  end
end
