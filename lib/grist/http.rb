# frozen_string_literal: true

module Grist
  module HTTP
    def get(path, **params)
      request(method: :get, path: path, query_params: params[:query_params])
    end

    def post(path, **params)
      request(method: :post, path: path, payload: params)
    end

    def put(path, **params)
      request(method: :put, path: path, payload: params)
    end

    def patch(path, **params)
      request(method: :patch, path: path, payload: params)
    end

    def destroy(path, **_params)
      request(method: :delete, path: path)
    end

    def conn
      ::Faraday.new(url: base_url) do |c|
        c.request :json
        c.request :authorization, "Bearer", @token

        c.response :json
        c.response :raise_error
        c.response :logger
      end
    end

    private

    def request(method: nil, path: "", payload: nil, headers: {}, query_params: {})
      url = url_with_query_params(path, query_params)
      connection.send(method, url, payload, headers)
    rescue ::Faraday::Error => e
      puts e.response[:status]
      puts e.response[:body]
    end

    def url_with_query_params(path, params)
      url = base_url + path
      url += "?" + ::URI.encode_www_form(params) unless params.empty?
      url
    end

    def base_url
      return "/api" if @url.nil?

      @base_url ||= relative_api_path
    end

    def relative_api_path
      return "/api" if @url.nil?

      api_path = if !@url.empty? && @url[-1] == "/"
                   "api"
                 else
                   "/api"
                 end

      @url + api_path
    end
  end
end
