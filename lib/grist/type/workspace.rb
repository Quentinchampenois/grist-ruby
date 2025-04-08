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
        @org_id = params[:org_id]
        @docs = []
        super params
      end

      def docs
        return @docs if @docs&.any? && @docs.first.is_a?(Doc)

        if @docs.any? && @docs.first.is_a?(Hash)
          @docs = @docs.map do |doc|
            Doc.new(doc.merge(ws_id: @id))
          end
        end

        @docs
      end

      # Create a new Doc in the workspace
      # @param data [Hash] The data to create the doc with
      # @return [Grist::Type::Doc, nil] The created doc or nil if not found
      def create_doc(data)
        grist_res = request(:post, doc_path, data)

        return unless grist_res.success?

        data["id"] = grist_res.data
        data.transform_keys!(&:to_s)
        doc = Doc.new(data)
        @docs ||= []
        @docs << doc

        doc
      end

      # Creates the workspace
      # @param id [Integer] The ID of the workspace to create
      # @param data [Hash] The data to create the workspace with
      # @return [Grist::Type::Workspace, nil] The created workspace or nil if not found
      def self.create(org_id, data)
        org = Type::Organization.find(org_id)
        org.create_workspace(data)
      end

      # List all workspaces
      # @param org_id [Integer] The ID of the organization to list workspaces for
      # @return [Array] Array of workspaces
      def self.all(org_id)
        grist_res = new(org_id: org_id).list

        return [] unless grist_res&.data.is_a?(Array)
        return [] unless grist_res&.data&.any?

        grist_res.data.map { |org| Workspace.new(org) }
      end

      private

      # @note Method to create a new doc in workspace
      # @note API: https://support.getgrist.com/api/#tag/docs/operation/createDoc
      def doc_path
        "/workspaces/#{@id}/docs"
      end
    end
  end
end
