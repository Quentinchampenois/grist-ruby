module Grist
  class Client
    attr_accessor :base_url

    BASE_URL = "https://api.getgrist.com"

    def initialize(url: nil)
      @base_url = url || BASE_URL
    end
  end
end