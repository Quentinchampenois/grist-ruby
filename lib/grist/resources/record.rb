module Grist
  module Resources
    class Record < Base

      def initialize(client)
        @client = client
      end

      # Fetch all records from a table
      def all(doc_id, table_id, params = {})
        endpoint = "docs/#{doc_id}/tables/#{table_id}/records"
        @client.request(:get, endpoint, params)
      end

      # Create new records in a table
      def create(doc_id, table_id, records)
        endpoint = "docs/#{doc_id}/tables/#{table_id}/records"
        payload = { records: records }
        @client.request(:post, endpoint, payload)
      end

      # Update existing records in a table
      def update(doc_id, table_id, records)
        endpoint = "docs/#{doc_id}/tables/#{table_id}/records"
        payload = { records: records }
        @client.request(:patch, endpoint, payload)
      end

      # Add or update records in a table
      def add_or_update(doc_id, table_id, records)
        endpoint = "docs/#{doc_id}/tables/#{table_id}/records"
        payload = { records: records }
        @client.request(:put, endpoint, payload)
      end

      # Delete records from a table
      def delete(doc_id, table_id, record_ids)
        endpoint = "docs/#{doc_id}/tables/#{table_id}/data/delete"
        payload = { ids: record_ids }
        @client.request(:delete, endpoint, payload)
      end
    end
  end
end
