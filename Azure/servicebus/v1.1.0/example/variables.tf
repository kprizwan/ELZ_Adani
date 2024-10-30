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

#SERVICEBUS
variable "servicebus_variables" {
  type = map(object({
    resource_group_name = string
    name                = string
    location            = string
    sku                 = string
    capacity            = string
    zone_redundant      = string
    local_auth_enabled  = bool
    servicebus_tags     = map(string)
    queue_name          = string
    namespace_name      = string
    topic_name          = string
    topic_id            = string
    resource_group_name = string
    subscription_name   = string
    topic_name          = string
    max_delivery_count  = string
  }))
}

