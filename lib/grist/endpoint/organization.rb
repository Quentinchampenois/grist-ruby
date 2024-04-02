module Grist
  module Endpoint
    module Organization
      def list
        get("/orgs")
      end

      def find(id)
        get("/orgs/#{id}")
      end
    end
  end
end