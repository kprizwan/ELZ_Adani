#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}
variable "user_assigned_identity_variables" {
  description = "Map of user assigned identity"
  type = map(object({
    user_assigned_identity_name                = string
    user_assigned_identity_location            = string
    user_assigned_identity_resource_group_name = string
    user_assigned_identity_tags                = map(string)
  }))
  default = {}
}
#AUTOMATION ACCOUNT VARIABLES

variable "automation_account_variables" {
  type = map(object({
    automation_account_name                          = string
    automation_account_location                      = string
    automation_account_resource_group_name           = string
    automation_account_sku_name                      = string
    automation_account_public_network_access_enabled = bool
    automation_account_tags                          = map(string)
    automation_account_identity = object({
      automation_account_identity_type = string
      automation_account_identity_identity = list(object({
        user_assigned_identity_name                = string
        user_assigned_identity_resource_group_name = string
      }))
    })
  }))
}
