# frozen_string_literal: true

require "grist/endpoint/organization"
require "grist/endpoint/workspace"
require "grist/endpoint/document"

module Grist
  module Endpoint
    include Organization
    include Workspace
    include Document
  end
end
