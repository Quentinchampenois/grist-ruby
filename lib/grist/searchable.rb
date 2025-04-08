# frozen_string_literal: true

module Grist
  module Searchable
    # Finds a record based on the given parameters.
    # @param params [Hash] The parameters to search for
    # @return [Array] The records that match the given parameters
    def self.find_by(*params)
      objs = all
      objs.select do |obj|
        params.all? do |key, value|
          obj.instance_variable_get("@#{key}") == value
        end
      end
    end
  end
end
