module Grist
  class Client
    attr_accessor :base_url, :api_key

    BASE_URL = "https://api.getgrist.com"

    def initialize(url: nil, api_key: nil)
      @base_url = url || BASE_URL
      raise MissingApiKey if api_key.nil?

      @api_key = api_key
    end
  end
end