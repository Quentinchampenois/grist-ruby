# frozen_string_literal: true

require "grist/endpoint/organization"
require "grist/endpoint/workspace"

module Grist
  module Endpoint
    include Organization
    include Workspace
  end
end
