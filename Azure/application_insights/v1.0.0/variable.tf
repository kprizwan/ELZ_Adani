variable "application_insights_variables" {
  type = map(object({
    name                      = string
    resource_group_name       = string
    location                  = string
    application_type          = string
    retention_in_days         = number
    disable_ip_masking        = bool
    application_insights_tags = map(string)
  }))
}
