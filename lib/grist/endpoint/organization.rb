# frozen_string_literal: true

module Grist
  module Endpoint
    module Organization
      def organizations
        get("/orgs")
      end

      def organization(id)
        get("/orgs/#{id}")
      end

      def update(id, payload, **params)
        patch("/orgs/#{id}", payload, params)
      end
      alias update_organization update

      def list_users_with_access(id)
        get("/orgs/#{id}/access")
      end

      def manage_access(id, **params)
        patch("/orgs/#{id}/access", params)
      end
    end
  end
end
