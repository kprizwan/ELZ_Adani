#Postgresql Database VARIABLES
variable "postgresql_database_variables" {
  type = map(object({
    postgresql_database_name                = string
    postgresql_database_resource_group_name = string
    postgresql_database_server_name         = string
    postgresql_database_charset             = string
    postgresql_database_collation           = string
  }))
}
