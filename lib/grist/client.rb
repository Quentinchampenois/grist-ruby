module Grist
  class Client
    attr_reader :base_url, :base_api_url, :api_key

    BASE_URL = "https://api.getgrist.com"

    def initialize(api_key:, base_url:)
      @base_url = base_url || BASE_URL
      @base_api_url = "#{base_url}/api"
      @api_key = api_key
    end

    def request(method, endpoint, params = {})
      uri = URI("#{base_api_url}/#{endpoint}")
      uri.query = URI.encode_www_form(params) if method == :get

      http = ::Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = !localhost?

      request = ::Net::HTTP::const_get(method.capitalize).new(uri)
      request["Authorization"] = "Bearer #{api_key}"
      request["Content-Type"] = "application/json"
      request.body = params.to_json unless method == :get

      response = http.request(request)
      raise InvalidAPIKey if response.is_a?(Net::HTTPUnauthorized)

      data = JSON.parse(response.body)
      # raise APIError, data["error"] if !data["error"].nil? && !data["error"].empty?
      Grist::Response.new(data: data, code: response&.code)
    rescue Net::OpenTimeout, Net::ReadTimeout
      Grist::Response.new(code: response&.code, error: "Grist API URL endpoint timed out")
    rescue SocketError
      Grist::Response.new(code: response&.code, error: "Grist API URL endpoint cannot be reached")
    rescue InvalidAPIKey
      Grist::Response.new(code: response&.code, error: "Unauthorized API key")
    rescue StandardError => e
      Grist::Response.new(code: response&.code, error: e.message)
    end

    private

    def localhost?
      base_url.include?("http://localhost")
    end
  end
end