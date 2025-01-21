module Grist
  module Resources
    module Orgs
      class Access < Resource
        def initialize(client, org_id)
          super(client, "orgs/#{org_id}/access")
        end
      end
    end
  end
end