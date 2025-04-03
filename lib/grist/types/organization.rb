# frozen_string_literal: true

module Grist
  module Types
    # Defines a Grist Organization
    class Organization
      include Rest
      include Accessible

      PATH = "/orgs"
      KEYS = %w[
        id
        name
        createdAt
        updatedAt
        domain
        host
        owner
      ].freeze

      attr_accessor(*KEYS)
      attr_reader :workspaces

      def initialize(params = {})
        KEYS.each do |key|
          instance_variable_set("@#{key}", params[key])
        end
      end

      def deleted?
        @deleted ||= false
      end

      def list_workspaces
        request(:get, workspaces_path)
      end

      # Create a new Workspace in the organization
      # # @param data [Hash] The data to create the workspace with
      # # # @return [self | nil] The organization or nil if not found
      def create_workspace(data)
        grist_res = request(:post, workspaces_path, data)

        return unless grist_res.success?

        data["id"] = grist_res.data
        data.transform_keys!(&:to_s)

        Workspace.new(data)
      end

      def workspaces_path
        "#{path}/#{@id}/workspaces"
      end

      # List all organizations
      # # # @return [Array] Array of organizations
      def self.all
        grist_res = new.list
        return [] unless grist_res&.data.is_a?(Array)

        grist_res.data&.map { |org| Organization.new(org) }
      end

      # Finds an organization by ID
      # # @param id [Integer] The ID of the organization to find
      # # # return [self | nil] The organization or nil if not found
      def self.find(id)
        grist_res = new.get(id)
        return unless grist_res.success? && grist_res.data

        new(grist_res.data)
      end

      # Updates the organization
      # # @param id [Integer] The ID of the organization to delete
      # # # @param data [Hash] The data to update the organization with
      # # @return [self | nil] The updated organization or nil if not found
      def self.update(id, data)
        org = find(id)
        return unless org

        org.update(data)
      end

      # Deletes the organization
      # # @param id [Integer] The ID of the organization to delete
      # # @return [self | nil] The deleted organization or nil if not found
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

      def self.list_workspaces(id)
        org = find(id)
        grist_res = org.list_workspaces
        return unless grist_res.success? && grist_res.data

        grist_res.data.map do |workspace|
          Workspace.new(workspace)
        end
      end

      def self.create_workspace(org_id, data)
        org = find(org_id)
        return unless org

        org.create_workspace(data)
      end
    end
  end
end
