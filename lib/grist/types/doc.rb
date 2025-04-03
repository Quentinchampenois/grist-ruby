# frozen_string_literal: true

module Grist
  module Types
    # Defines a Grist Workspace
    class Doc
      include Rest
      include Accessible

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
        @ws_id = params[:ws_id]
        KEYS.each do |key|
          instance_variable_set("@#{key}", params[key])
        end
      end

      def deleted?
        @deleted ||= false
      end

      def tables_path
        "#{path}/#{@id}/tables"
      end

      def tables
        grist_res = request(:get, tables_path)
        puts grist_res.inspect
        return [] unless grist_res&.data.is_a?(Array)

        @tables = grist_res.data&.map { |org| Table.new(org) }

        self
      end

      def create_tables(data)
        grist_res = request(:post, tables_path, data)
        puts grist_res.inspect
        return [] unless grist_res&.data.is_a?(Array)

        @tables = grist_res.data&.map { |org| Table.new(org) }

        self
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

      def self.tables(doc_id)
        org = find(doc_id)
        byebug
        return unless org

        org.tables
      end
    end
  end
end
