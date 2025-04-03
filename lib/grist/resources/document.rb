# frozen_string_literal: true

module Grist
  module Resources
    class Document < Base
      def initialize(client)
        super(client, "docs")
      end

      def download_sql(doc_id)
        client.request(:get, "docs/#{doc_id}/download")
      end

      def move(doc_id, data)
        client.request(:post, "docs/#{doc_id}/move", data)
      end

      def force_reload(doc_id)
        client.request(:post, "docs/#{doc_id}/force-reload")
      end
    end
  end
end
