# frozen_string_literal: true

require "grist/http"
require "grist/endpoint"

module Grist
  class Client
    include HTTP
    include Endpoint

    def initialize(url: nil, token: nil)
      @url = url
      @token = token
    end

    def connection
      @connection ||= conn
    end
  end
end
