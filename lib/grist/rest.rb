# frozen_string_literal: true

module Grist
  module Rest
    def request(method, endpoint, params = {})
      uri = URI("#{::Grist.base_api_url}#{endpoint}")
      uri.query = URI.encode_www_form(params) if method == :get

      http = ::Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = !::Grist.localhost?

      request = ::Net::HTTP.const_get(method.capitalize).new(uri)
      request["Authorization"] = ::Grist.token_auth
      request["Content-Type"] = "application/json"
      request.body = params.to_json unless method == :get

      response = http.request(request)

      raise InvalidApiKey, "Invalid API key" if response.is_a?(Net::HTTPUnauthorized)
      raise NotFound, "Resource not found at : #{request.uri}" if response.is_a?(Net::HTTPNotFound)

      data = response_body(response.body)

      Grist::Response.new(data: data, code: response.code)
    rescue Net::OpenTimeout, Net::ReadTimeout, SocketError => e
      res = Grist::Response.new(code: response&.code, error: "Grist endpoint is unreachable at #{request.uri}",
                                type: e.class)
      res.log_error
      raise NetworkError, res.print_error
    rescue APIError => e
      res = Grist::Response.new(code: response&.code, error: e.message, type: e.class)
      res.log_error
      raise APIError, res.print_error
    rescue StandardError => e
      res = Grist::Response.new(code: response&.code, error: e.message, type: e.class)
      res.log_error
      res
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

    def response_body(str)
      return {} if str.nil? || str.empty?

      JSON.parse(str)
    end
  end
end
