module Grist
  class Client
    attr_reader :base_url, :api_key

    BASE_URL = "https://api.getgrist.com"

    def initialize(api_key:, url:)
      @base_url = url || BASE_URL
      @api_key = api_key
    end

    def request(method, endpoint, params = {})
      uri = URI("#{base_url}/#{endpoint}")
      uri.query = URI.encode_www_form(params) if method == :get

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::const_get(method.capitalize).new(uri)
      request["Authorization"] = "Bearer #{api_key}"
      request["Content-Type"] = "application/json"
      request.body = params.to_json unless method == :get

      response = http.request(request)
      JSON.parse(response.body)
    rescue StandardError => e
      { error: e.message }
    end
  end
end