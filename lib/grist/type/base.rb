# frozen_string_literal: true

module Grist
  module Type
    class Base
      include Rest
      include Accessible
      include Searchable

      PATH = ""
      KEYS = %w[].freeze
      attr_accessor(*KEYS)

      def initialize(params = {})
        keys.each do |key|
          instance_variable_set("@#{key}", params[key])
        end
        @deleted = params.delete(:deleted) || false
      end

      def keys
        self.class::KEYS
      end

      def deleted?
        !!@deleted
      end

      # List all items
      # @return [Array] Array of items
      def self.all
        grist_res = new.list

        return [] unless grist_res&.data.is_a?(Array)
        return [] unless grist_res&.data&.any?

        grist_res.data.map { |org| new(org) }
      end

      # Finds an item by ID
      # @param id [Integer] The ID of the item to find
      # return [Grist::Type::Base, nil] The item or nil if not found
      def self.find(id)
        grist_res = new.get(id)
        return unless grist_res.success? && grist_res.data

        new(grist_res.data)
      end

      # Updates the item
      # @param id [Integer] The ID of the item to delete
      # @param data [Hash] The data to update the item with
      # @return [Grist::Type::Base, nil] The updated item or nil if not found
      def self.update(id, data)
        org = find(id)
        return unless org

        org.update(data)
      end

      # Deletes the item
      # @param id [Integer] The ID of the item to delete
      # @return [Grist::Type::Base, nil] The deleted item or nil if not found
      def self.delete(id)
        org = find(id)
        return unless org

        org.delete
      end
    end
  end
end
