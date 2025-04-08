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
    end
  end
end
