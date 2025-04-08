# frozen_string_literal: true

module Grist
  module Type
    # Defines a Grist Workspace
    class Column
      include Rest

      PATH = "/docs"
      KEYS = %w[
        id
        fields
      ].freeze

      attr_accessor(*KEYS)

      def initialize(params = {})
        @doc_id = params[:doc_id]
        KEYS.each do |key|
          instance_variable_set("@#{key}", params[key])
        end
      end
    end
  end
end
