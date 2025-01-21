module Grist
  module Resources
    module Orgs
      class Workspace < Resource
        def initialize(client, org_id)
          super(client, "orgs/#{org_id}/workspaces")
        end
      end
    end
  end
end