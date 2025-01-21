
module Grist
  class Resource
    attr_reader :client, :resource_name

    def initialize(client, resource_name)
      @client = client
      @resource_name = resource_name
    end

    def all(params = {})
      result client.request(:get, resource_name, params)
    end

    def find(id)
      result client.request(:get, "#{resource_name}/#{id}")
    end

    def create(attrs = {})
      result client.request(:post, resource_name, attrs)
    end

    def update(id, attrs = {})
      result client.request(:put, "#{resource_name}/#{id}", attrs)
    end

    def delete(id)
      result client.request(:delete, "#{resource_name}/#{id}")
    end

    def sub_resource(id, sub_path)
      self.class.new(client, "#{resource_name}/#{id}/#{sub_path}")
    end

    private

    def result(request)
      data = request[:data]
      error = request[:error]

      OpenStruct.new(
        results: data,
        error: error,
        success?: error.nil?,
        error?: !error.nil?
      )
    end
  end
end
