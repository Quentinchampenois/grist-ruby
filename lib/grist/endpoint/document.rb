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

      def delete_document(id)
        destroy("/docs/#{id}")
      end
    end
  end
end
