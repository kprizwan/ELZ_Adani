## Attributes:

- postgresql_database_name                = string #(Required) Specifies the name of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created.
- postgresql_database_resource_group_name = string #(Required) The name of the resource group in which the PostgreSQL Server exists. Changing this forces a new resource to be created.
- postgresql_database_server_name         = string #(Required) Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created.
- postgresql_database_charset             = string #(Required) Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created.
- postgresql_database_collation           = string #(Required) Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created.