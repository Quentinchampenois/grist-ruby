module Grist
  class API
    attr_reader :client

    def initialize(api_key:, base_url: 'https://api.getgrist.com')
      @client = Client.new(api_key: api_key, base_url: base_url)
    end

    def organizations
      Resources::Organization.new(client)
    end

    def workspaces
      Resources::Workspace.new(client)
    end

    def documents
      Resources::Document.new(client)
    end

    def tables(doc_id)
      Resources::Table.new(client, doc_id)
    end

    def records(doc_id, table_id)
      Resources::Record.new(client, doc_id, table_id)
    end
  end
end
