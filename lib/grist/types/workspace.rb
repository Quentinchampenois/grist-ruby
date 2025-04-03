# frozen_string_literal: true

module Grist
  module Types
    # Defines a Grist Workspace
    class Workspace
      include Rest
      include Accessible

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
        KEYS.each do |key|
          instance_variable_set("@#{key}", params[key])
        end
        @org_id = params[:org_id]
        @docs = []
      end

      # def docs
      #   grist_res = request(:get, create_doc_path)
      #   return [] unless grist_res.success? && grist_res.data
      #
      #   @docs = grist_res.data.map do |doc|
      #     doc["id"] = doc["urlId"]
      #     doc.transform_keys!(&:to_s)
      #     doc["workspace_id"] = @id
      #     doc["org_id"] = @org_id
      #     doc["owner"] = @owner
      #     doc["access"] = @access
      #     doc["createdAt"] = Time.parse(doc["createdAt"])
      #     doc["updatedAt"] = Time.parse(doc["updatedAt"])
      #     Doc.new(doc)
      #   end
      # end

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

      # def base_api_url
      #   "#{ENV["GRIST_API_URL"]}/api/orgs/#{@org_id}"
      # end

      # Creates the workspace
      # # @param id [Integer] The ID of the workspace to create
      # # # @param data [Hash] The data to create the workspace with
      # # @return [self | nil] The created workspace or nil if not found
      def self.create(org_id, data)
        org = Types::Organization.find(org_id)
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
