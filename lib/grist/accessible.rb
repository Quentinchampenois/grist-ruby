# frozen_string_literal: true

module Grist
  module Accessible
    def access
      id = instance_variable_get("@id")
      request(:get, "#{path}/#{id}/access")
    end
  end
end
