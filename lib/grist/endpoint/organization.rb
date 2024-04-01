module Grist
  module Endpoint
    module Organization
      def list
        get("/orgs")
      end
    end
  end
end