module Grist
  module Resources
    class Table < Base
      def initialize(client, doc_id)
        super(client, "docs/#{doc_id}/tables")
      end

      def columns(table_id)
        client.request(:get, "#{path}/#{table_id}/columns")
      end
    end
  end
end
