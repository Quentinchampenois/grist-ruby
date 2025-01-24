module Grist
  module ApiRoutes
    ### ORGANIATIONS
    ORG_ALL = "https://{gristhost}/api/orgs"
    ORG_FIND = "https://{gristhost}/api/orgs/{orgId}"
    ORG_UPDATE = "https://{gristhost}/api/orgs/{orgId}"
    ORG_DELETE = "https://{gristhost}/api/orgs/{orgId}"
    # ORG ACCESS
    ORG_ACCESS_ALL = "https://{gristhost}/api/orgs/{orgId}/access"
    ORG_ACCESS_UPDATE = "https://{gristhost}/api/orgs/{orgId}/access"
    # ORG WORKSPACE
    WORKSPACE_ALL = "https://{gristhost}/api/orgs/{orgId}/workspaces"
    WORKSPACE_CREATE = "https://{gristhost}/api/orgs/{orgId}/workspaces"

    ### WORKSPACES
    WORKSPACE_FIND = "https://{gristhost}/api/workspaces/{workspaceId}"
    WORKSPACE_UPDATE = "https://{gristhost}/api/workspaces/{workspaceId}"
    WORKSPACE_DELETE = "https://{gristhost}/api/workspaces/{workspaceId}"
    # WORKSPACE ACCESS
    WORKSPACE_ACCESS_ALL = "https://{gristhost}/api/workspaces/{orgId}/access"
    WORKSPACE_ACCESS_UPDATE = "https://{gristhost}/api/workspaces/{orgId}/access"
    # WORKSPACE DOCUMENTS
    DOC_CREATE = "https://{gristhost}/api/workspaces/{workspaceId}/docs"

    ### DOCUMENTS
    DOC_FIND = "https://{gristhost}/api/docs/{docId}"
    DOC_UPDATE = "https://{gristhost}/api/docs/{docId}"
    DOC_DELETE = "https://{gristhost}/api/docs/{docId}"
    DOC_MOVE = "https://{gristhost}/api/docs/{docId}/move"
    # DOC ACCESS
    DOC_ACCESS_ALL = "https://{gristhost}/api/docs/{docId}/access"
    DOC_ACCESS_UPDATE = "https://{gristhost}/api/docs/{docId}/access"
    # DOC ACCESS
    DOC_DL_SQL = "https://{gristhost}/api/docs/{docId}/download"
    DOC_DL_EXCEL = "https://{gristhost}/api/docs/{docId}/download/xlsx"
    DOC_DL_CSV = "https://{gristhost}/api/docs/{docId}/download/csv"
    DOC_DL_TABLE_SCHEMA = "https://{gristhost}/api/docs/{docId}/download/table-schema"
    DOC_TRUNCATE_HISTORY = "https://{gristhost}/api/docs/{docId}/states/remove"
    DOC_FORCE_RELOAD = "https://{gristhost}/api/docs/{docId}/force-reload"
    DOC_CLEAR_QUEUE = "https://{gristhost}/api/docs/{docId}/webhooks/queue"

    ### RECORDS
    RECORD_ALL = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/records"
    RECORD_CREATE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/records"
    RECORD_UPDATE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/records"
    RECORD_ADD_OR_UPDATE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/records"

    ### TABLES
    TABLE_ALL = "https://{gristhost}/api/docs/{docId}/tables"
    TABLE_CREATE = "https://{gristhost}/api/docs/{docId}/tables"
    TABLE_UPDATE = "https://{gristhost}/api/docs/{docId}/tables"

    ### COLUMNS
    COLUMN_ALL = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/columns"
    COLUMN_CREATE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/columns"
    COLUMN_UPDATE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/columns"
    COLUMN_ADD_OR_UPDATE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/columns"
    COLUMN_DELETE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/columns/{colId}"

    ### ROWS
    ROW_DELETE = "https://{gristhost}/api/docs/{docId}/tables/{tableId}/data/delete"

    ### ATTACHMENTS
    ATTACHMENT_ALL = "https://{gristhost}/api/docs/{docId}/attachments"
    ATTACHMENT_UPDATE = "https://{gristhost}/api/docs/{docId}/attachments"
    ATTACHMENT_METADATA = "https://{gristhost}/api/docs/{docId}/attachments/{attachmentId}"
    ATTACHMENT_DL_CONTENT = "https://{gristhost}/api/docs/{docId}/attachments/{attachmentId}/download"

    ### WEBHOOKS
    WEBHOOK_ALL = "https://{gristhost}/api/docs/{docId}/webhooks"
    WEBHOOK_CREATE = "https://{gristhost}/api/docs/{docId}/webhooks"
    WEBHOOK_UPDATE = "https://{gristhost}/api/docs/{docId}/webhooks/{webhookId}"
    WEBHOOK_DELETE = "https://{gristhost}/api/docs/{docId}/webhooks/{webhookId}"

    USER_DELETE = "https://{gristhost}/api/users/{userId}"
  end
end