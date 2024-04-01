
require "grist/http"
require "grist/endpoint"

module Grist
  class Client
    include HTTP
    include Endpoint

    def initialize(url: nil)
      @url = url
    end

    def connection
      @connection ||= conn
    end
  end
end