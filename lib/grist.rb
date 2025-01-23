# frozen_string_literal: true

require 'net/http'
require 'json'
require 'byebug'
require_relative "grist/api"
require_relative "grist/version"
require_relative "grist/client"
require_relative "grist/resource"
require_relative "grist/resources/base"
require_relative "grist/resources/document"
require_relative "grist/resources/record"
require_relative "grist/resources/table"


module Grist
  class Error < StandardError; end
  class InvalidAPIKey < Error; end
end
