# frozen_string_literal: true

module Grist
  module Type
    # Defines a Grist Workspace
    class Workspace < Grist::Type::Base
      PATH = "/workspaces"
      KEYS = %w[
        id
        name
        createdAt
        updatedAt
        isSupportWorkspace
        docs
        access
        owner
        orgDomain
      ].freeze

      attr_accessor(*KEYS)
      attr_reader :org_id

      def initialize(params = {})
        super params
        @org_id = params[:org_id]
        @docs = []
      end

      def deleted?
        @deleted ||= false
      end

      def base_api_url
        "#{ENV["GRIST_API_URL"]}/api"
      end

      # @note Method to create a new doc in workspace
      # @note API: https://support.getgrist.com/api/#tag/docs/operation/createDoc
      def create_doc_path
        "/workspaces/#{@id}/docs"
      end

      # Create a new Doc in the workspace
      # # @param data [Hash] The data to create the doc with
      # # # @return [self | nil] The created doc or nil if not found
      def create_doc(data)
        grist_res = request(:post, create_doc_path, data)

        return unless grist_res.success?

        @docs ||= []
        data["id"] = grist_res.data
        data.transform_keys!(&:to_s)
        doc = Doc.new(data)
        @docs << doc

        doc
      end

      # Creates the workspace
      # # @param id [Integer] The ID of the workspace to create
      # # # @param data [Hash] The data to create the workspace with
      # # @return [self | nil] The created workspace or nil if not found
      def self.create(org_id, data)
        org = Type::Organization.find(org_id)
        org.create_workspace(data)
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
        obj = find(id)
        return unless obj

        obj.update(data)
      end

      # Deletes the workspace
      # # @param id [Integer] The ID of the workspace to delete
      # # @return [self | nil] The deleted workspace or nil if not found
      def self.delete(id)
        obj = find(id)
        return unless obj

        obj.delete
      end
    end
  end
end
