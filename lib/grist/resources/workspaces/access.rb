module Grist
  module Resources
    module Workspaces
      class Access < Resource
        def initialize(client, org_id)
          super(client, "workspaces/#{org_id}/access")
        end
      end
    end
  end
end