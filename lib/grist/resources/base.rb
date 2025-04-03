# frozen_string_literal: true

module Grist
  module Resources
    class Base
      attr_reader :client, :path

      def initialize(client, path)
        @client = client
        @path = path
      end

      def list(params = {})
        client.request(:get, path, params)
      end

      def get(id)
        client.request(:get, "#{path}/#{id}")
      end

      def create(data)
        client.request(:post, path, data)
      end

      def update(id, data)
        client.request(:patch, "#{path}/#{id}", data)
      end

      def delete(id)
        client.request(:delete, "#{path}/#{id}")
      end
    end
  end
end
