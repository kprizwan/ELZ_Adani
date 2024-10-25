variable "automation_account_variables" {
  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    sku_name                = string
    automation_account_tags = map(string)
    identity_type           = string
    user_identity_name      = string
  }))
}
