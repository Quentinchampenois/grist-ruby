module Grist
  class Records < Resource
    def initialize(client, doc_id, table_id)
      super(client, "docs/#{doc_id}/tables/#{table_id}/records")
    end
  end
end
