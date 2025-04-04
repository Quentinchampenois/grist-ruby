# frozen_string_literal: true

module Grist
  module Type
    # Defines a Grist Workspace
    class Doc < Grist::Type::Base
      PATH = "/docs"
      KEYS = %w[
        name
        createdAt
        updatedAt
        id
        isPinned
        urlId
        trunkId
        type
        forks
        access
      ].freeze

      attr_accessor(*KEYS)

      def initialize(params = {})
        super params
        @ws_id = params[:ws_id]
        @tables = []
      end

      def tables_path
        "#{path}/#{@id}/tables"
      end

      def tables
        grist_res = request(:get, tables_path)
        return [] if grist_res&.error?

        @tables = grist_res.data["tables"]&.map do |t|
          Table.new(t.merge(doc_id: @id, ws_id: @ws_id))
        end
        @tables
      end

      def create_tables(data)
        grist_res = request(:post, tables_path, data)
        puts grist_res.inspect
        return [] unless grist_res&.data.is_a?(Array)

        @tables = grist_res.data&.map { |org| Table.new(org) }
      end

      # def base_api_url
      #   "#{ENV["GRIST_API_URL"]}/api/orgs/#{@org_id}"
      # end

      # Updates the workspace
      # # @param id [Integer] The ID of the workspace to delete
      # # # @param data [Hash] The data to update the workspace with
      # # @return [self | nil] The updated workspace or nil if not found
      def self.create(ws_id, data)
        obj = new(ws_id: ws_id)
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
        puts grist_res.inspect
        return unless grist_res.success? && grist_res.data

        new(grist_res.data)
      end

      def self.tables(doc_id)
        org = find(doc_id)
        return unless org

        org.tables
      end
    end
  end
end
