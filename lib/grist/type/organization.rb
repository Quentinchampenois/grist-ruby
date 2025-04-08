# frozen_string_literal: true

module Grist
  module Type
    # Defines a Grist Organization
    class Organization < Grist::Type::Base
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

      # Initialize a new Organization
      # @param params [Hash] The parameters to initialize the organization with
      # @return [Grist::Type::Organization] The organization
      # @note API: https://support.getgrist.com/api/#tag/organizations
      # @example
      #  org = Grist::Type::Organization.new(
      #  "id" => 1,
      #  "name" => "Grist Labs",
      #  "domain" => "gristlabs",
      #  "host" => "gristlabs.com",
      # )
      def initialize(params = {})
        super params
        @workspaces = []
      end

      # List Workspaces in the organization
      # @return [Array | nil] The workspaces array
      # @note API: https://support.getgrist.com/api/#tag/workspaces
      def list_workspaces
        grist_res = request(:get, workspaces_path)

        return [] unless grist_res.success? && grist_res.data

        grist_res.data.map do |workspace|
          Workspace.new(workspace)
        end
      end

      # Create a new Workspace in the organization
      # @param data [Hash] The data to create the workspace with
      # @return [Decidim::Type::Workspace, nil] The organization or nil if not found
      def create_workspace(data)
        grist_res = request(:post, workspaces_path, data)

        unless grist_res.success?
          grist_res.print_error
          return
        end

        data["id"] = grist_res.data
        data.transform_keys!(&:to_s)

        ws = Workspace.new(data)
        @workspaces << ws

        ws
      end

      # Get the path for the organization
      # @return [String] The path for the organization
      def workspaces_path
        "#{path}/#{@id}/workspaces"
      end

      # Get users which can access to the organization
      # @param id [Integer] The ID of the organization
      # @return [Array, nil] An array of Grist::Type::Access or nil
      def self.access(id)
        org = find(id)
        grist_res = org.access
        return unless grist_res.success? && grist_res.data

        grist_res.data["users"].map do |access|
          Access.new(access)
        end
      end

      # List workspaces in the organization
      # @param id [Integer] The ID of the organization
      # @return [Array] An array of Grist::Type::Workspace
      def self.list_workspaces(id)
        org = find(id)
        return [] unless org

        org.list_workspaces
      end

      # Create a new workspace in the organization
      # @param org_id [Integer] The ID of the organization
      # @param data [Hash] The data to create the workspace with
      # @return [Grist::Type::Workspace, nil] The created workspace or nil if not found
      def self.create_workspace(org_id, data)
        org = find(org_id)
        return unless org

        org.create_workspace(data)
      end
    end
  end
end
