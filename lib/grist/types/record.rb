# frozen_string_literal: true

module Grist
  module Types
    # Defines a Grist Workspace
    class Record
      include Rest

      PATH = "/records"
      KEYS = %w[
        id
        fields
      ].freeze

      attr_accessor(*KEYS)

      def initialize(params = {})
        KEYS.each do |key|
          instance_variable_set("@#{key}", params[key])
        end
        @table_id = params[:table_id]
        @doc_id = params[:doc_id]
      end
    end
  end
end
