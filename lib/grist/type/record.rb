# frozen_string_literal: true

module Grist
  module Type
    # Defines a Grist Workspace
    class Record < Grist::Type::Base
      PATH = "/records"
      KEYS = %w[
        id
        fields
      ].freeze

      attr_accessor(*KEYS)

      def initialize(params = {})
        super params
        @table_id = params[:table_id]
        @doc_id = params[:doc_id]
      end
    end
  end
end
