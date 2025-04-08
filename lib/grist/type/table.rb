# frozen_string_literal: true

module Grist
  module Type
    # Defines a Grist Workspace
    class Table < Grist::Type::Base
      KEYS = %w[
        id
        fields
        columns
      ].freeze

      attr_accessor(*KEYS)

      def initialize(params = {})
        @doc_id = params[:doc_id]
        super params
      end

      def to_hash
        {
          "id" => @id,
          "fields" => @fields,
          "columns" => @columns
        }
      end

      def columns_path
        "/docs/#{@doc_id}/tables/#{@id}/columns"
      end

      def columns
        grist_res = request(:get, columns_path)
        return [] unless grist_res.success? && grist_res.data

        grist_res.data.map do |column|
          Column.new(column)
        end
      end

      def records_path
        "/docs/#{@doc_id}/tables/#{@id}/records"
      end

      def records(params = {})
        grist_res = request(:get, records_path, params)

        return [] unless grist_res.success? && grist_res.data

        @records = grist_res.data["records"].map do |record|
          Record.new(record.merge(doc_id: @doc_id, table_id: @id))
        end

        @records
      end

      def create_records(data)
        grist_res = request(:post, records_path, data)
        return [] unless grist_res.success? && grist_res.data

        @records = grist_res.data["records"].map do |record|
          Record.new(record.merge(doc_id: @doc_id, table_id: @id))
        end

        @records
      end

      # def base_api_url
      #   "#{ENV["GRIST_API_URL"]}/api/orgs/#{@org_id}"
      # end

      # Updates the workspace
      # # @param id [Integer] The ID of the workspace to delete
      # # # @param data [Hash] The data to update the workspace with
      # # @return [self | nil] The updated workspace or nil if not found
      def self.create(doc_id, data)
        obj = new(doc_id: doc_id)
        obj.create(data)
      end

      # List all workspaces
      # # # @return [Array] Array of workspaces
      def self.all(org_id)
        grist_res = new(org_id: org_id).list
        return [] unless grist_res&.data.is_a?(Array)

        grist_res.data&.map { |org| Workspace.new(org) }
      end

      # Finds an workspace by ID
      # # @param id [Integer] The ID of the workspace to find
      # # # return [self | nil] The workspace or nil if not found
      def self.find(id)
        grist_res = new.get(id)
        return unless grist_res.success? && grist_res.data

        new(grist_res.data)
      end

      # Updates the workspace
      # # @param id [Integer] The ID of the workspace to delete
      # # # @param data [Hash] The data to update the workspace with
      # # @return [self | nil] The updated workspace or nil if not found
      def self.update(id, data)
        org = find(id)
        return unless org

        org.update(data)
      end

      # Deletes the workspace
      # # @param id [Integer] The ID of the workspace to delete
      # # @return [self | nil] The deleted workspace or nil if not found
      def self.delete(id)
        org = find(id)
        return unless org

        org.delete
      end

      def self.access(id)
        org = find(id)
        grist_res = org.access
        return unless grist_res.success? && grist_res.data

        grist_res.data["users"].map do |access|
          Access.new(access)
        end
      end
    end
  end
end
