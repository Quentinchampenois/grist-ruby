
module Grist
  class Resource
    attr_reader :client, :resource_name

    def initialize(client, resource_name)
      @client = client
      @resource_name = resource_name
    end

    def all(params = {})
      client.request(:get, resource_name, params)
    end

    def find(id)
      client.request(:get, "#{resource_name}/#{id}")
    end

    def create(attrs = {})
      client.request(:post, resource_name, attrs)
    end

    def update(id, attrs = {})
      client.request(:put, "#{resource_name}/#{id}", attrs)
    end

    def delete(id)
      client.request(:delete, "#{resource_name}/#{id}")
    end
  end
end
