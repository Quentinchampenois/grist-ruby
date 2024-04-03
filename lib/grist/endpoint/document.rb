# frozen_string_literal: true

module Grist
  module Endpoint
    module Document
      def describe_document(document_id)
        get("/docs/#{document_id}")
      end

      def create_document(workspace_id, payload, **params)
        post("/workspaces/#{workspace_id}/docs", payload, params)
      end

      def update_metadata_document(document_id, payload, **params)
        patch("/docs/#{document_id}", payload, params)
      end

      def move_document(document_id, workspace_id, **params)
        patch("/docs/#{document_id}/move", { workspace: workspace_id }, params)
      end

      def delete_document(id)
        destroy("/docs/#{id}")
      end

      def download_document(id, query_params)
        get("/docs/#{id}/download", query_params: query_params)
      end

      def list_users_document(id)
        get("/docs/#{id}/access")
      end

      def manage_access_document(id, payload, **params)
        patch("/docs/#{id}/access", payload, params)
      end
    end
  end
end
