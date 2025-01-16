# frozen_string_literal: true

require 'net/http'
require 'json'
require 'byebug'
require_relative "grist/version"
require_relative "grist/client"
require_relative "grist/resource"


module Grist
  class Error < StandardError; end
  class MissingApiKey < Error; end
end
