module Grist
  module Resources
      class Access < Resource
        def initialize(client, org_id)
          super(client, "#{org_id}/access")
        end
    end
  end
end