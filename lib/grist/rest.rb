# frozen_string_literal: true

module Grist
  module Rest
    def request(method, endpoint, params = {})
      uri = URI("#{base_api_url}#{endpoint}")
      uri.query = URI.encode_www_form(params) if method == :get

      http = ::Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = !localhost?

      request = ::Net::HTTP.const_get(method.capitalize).new(uri)
      request["Authorization"] = "Bearer #{api_key}"
      request["Content-Type"] = "application/json"
      request.body = params.to_json unless method == :get

      response = http.request(request)
      raise InvalidAPIKey if response.is_a?(Net::HTTPUnauthorized)
      raise "Resource not found for '#{request.uri}'" if response.is_a?(Net::HTTPNotFound)

      data = JSON.parse(response.body)
      # raise APIError, data["error"] if !data["error"].nil? && !data["error"].empty?
      Grist::Response.new(data: data, code: response&.code)
    rescue Net::OpenTimeout, Net::ReadTimeout, SocketError => e
      Grist::Response.new(code: response&.code, error: "Grist endpoint is unreachable", type: e.class)
    rescue InvalidAPIKey => e
      Grist::Response.new(code: response&.code, error: "Unauthorized API key", type: e.class)
    rescue StandardError => e
      Grist::Response.new(code: response&.code, error: e.message, type: e.class)
    end

    def api_key
      ENV["GRIST_API_KEY"]
    end

    def base_api_url
      "#{ENV["GRIST_API_URL"]}/api"
    end

    def path
      self.class::PATH
    end

    def list(params = {})
      request(:get, path, params)
    end

    def get(id)
      request(:get, "#{path}/#{id}")
    end

    def create(data)
      grist_res = request(:post, path, data)
      puts "Creating #{path} with data: #{data}"
      puts puts grist_res.inspect
      return unless grist_res.success?

      data.each_key do |key|
        instance_variable_set("@#{key}", data[key])
      end

      self
    end

    def update(data)
      id = instance_variable_get("@id")
      grist_res = request(:patch, "#{path}/#{id}", data)
      return unless grist_res.success?

      data.each_key do |key|
        instance_variable_set("@#{key}", data[key])
      end

      self
    end

    def delete
      id = instance_variable_get("@id")
      grist_res = request(:delete, "#{path}/#{id}")
      return unless grist_res.success?

      instance_variable_set("@deleted", true)

      self
    end

    private

    def localhost?
      base_api_url.include?("://localhost")
    end
  end
end
