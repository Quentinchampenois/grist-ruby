# frozen_string_literal: true

require_relative "grist/version"

module Grist
  class Error < StandardError; end
  class MissingApiKey < Error; end
end
