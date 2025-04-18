# frozen_string_literal: true

require "net/http"
require "logger"
require "json"
require_relative "grist/version"
require_relative "grist/rest"
require_relative "grist/accessible"
require_relative "grist/searchable"
require_relative "grist/type/base"
require_relative "grist/type/table"
require_relative "grist/type/record"
require_relative "grist/type/doc"
require_relative "grist/type/access"
require_relative "grist/type/workspace"
require_relative "grist/type/organization"
require_relative "grist/response"

module Grist
  class Error < StandardError
    def self.help; end
  end

  class NetworkError < Error; end
  class APIError < Error; end

  class InvalidApiKey < APIError
    def self.help
      "help: Ensure the GRIST_API_KEY environment variable is set and valid."
    end
  end

  class NotFound < APIError; end

  def self.logger
    @logger ||= Logger.new($stdout)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.api_key
    ENV["GRIST_API_KEY"]
  end

  def self.token_auth
    "Bearer #{Grist.api_key}"
  end

  def self.base_api_url
    base_api_url = ENV["GRIST_API_URL"]
    return base_api_url[0..-2] if !base_api_url.nil? && base_api_url != "" && base_api_url.end_with?("/")

    base_api_url
  end

  def self.localhost?
    base_api_url.include?("http://localhost")
  end
end
