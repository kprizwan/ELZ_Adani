variable "resource_group_variables" {
  type = map(object({
    resource_group_name = string
    location            = string
    resource_group_tags = map(string)
  }))
}

variable "servicebus_namespace_variables" {
  type = map(object({
    resource_group_name = string
    name                = string
    location            = string
    sku                 = string
    capacity            = string
    zone_redundant      = string
    servicebus_tags     = map(string)
    # servicebus_namespace_lock_name  = string
    # servicebus_namespace_lock_level = string
    # servicebus_namespace_lock_scope = string
  }))
}

variable "servicebus_queue_variables" {
  type = map(object({
    resource_group_name = string
    name                = string
    namespace_name      = string
  }))
}

variable "servicebus_topic_variables" {
  type = map(object({
    resource_group_name = string
    name                = string
    namespace_name      = string
  }))
}

variable "servicebus_subscription_variables" {
  type = map(object({
    resource_group_name = string
    name                = string
    namespace_name      = string
    topic_name          = string
    max_delivery_count  = string
  }))
}



# variable "servicebus_variables" {
#   type = map(object({
#     name                            = string
#     resource_group_name             = string
#     location                        = string
#     namespace_name                  = string
#     namespace_sku                   = string
#     namespace_capacity              = string
#     redundency                      = string
#     tags                            = string
#     servicebus_namespace_lock_name  = string
#     servicebus_namespace_lock_level = string
#     servicebus_namespace_lock_scope = string
#   }))
# }