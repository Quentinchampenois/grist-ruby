module Grist
  module HTTP
    def get(path, **params)
      request(method: :get, path: path)
    end

    def post(path, **params)
      request(method: :post, path: path, payload: params)
    end

    def put(path, **params)
      request(method: :put, path: path, payload: params)
    end

    def delete(path, **params)
      request(method: :delete, path: path)
    end

    private

    def request(method: nil, path: "", payload: nil, headers: {})
      connection.send(method, path, payload, headers)
    rescue Faraday::Error => e
      puts e.response[:status]
      puts e.response[:body]
    end
  end

  def conn
    Faraday.new(url: @url) do |builder|
      builder.request :json
      builder.response :json
      builder.response :raise_error
      builder.response :logger
    end
  end
end
