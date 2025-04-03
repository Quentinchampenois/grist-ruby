# frozen_string_literal: true

require "net/http"
require "json"
require "byebug"
require_relative "grist/api"
require_relative "grist/version"
require_relative "grist/rest"
require_relative "grist/accessible"
require_relative "grist/types/table"
require_relative "grist/types/record"
require_relative "grist/types/doc"
require_relative "grist/types/access"
require_relative "grist/types/workspace"
require_relative "grist/types/organization"
require_relative "grist/client"
require_relative "grist/response"
require_relative "grist/resources/base"
require_relative "grist/resources/organization"
require_relative "grist/resources/document"
require_relative "grist/resources/record"
require_relative "grist/resources/table"

module Grist
  class APIError < StandardError; end

  class Error < StandardError; end

  class InvalidAPIKey < Error; end

  def self.api_key
    ENV["GRIST_API_KEY"]
  end

  def self.token_auth
    "Bearer #{Grist.api_key}"
  end

  def self.base_api_url
    base_api_url = ENV["GRIST_API_URL"]
    if base_api_url.nil? && base_api_url != "" && base_api_url.end_with?("/")
      return base_api_url[0..-2]
    end

    base_api_url
  end

  def self.localhost?
    base_api_url.include?("http://localhost")
  end
end
