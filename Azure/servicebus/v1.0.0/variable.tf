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


# variable "create_resource_group" {
#   description = "Option to create a Azure resource group to use for VNET"
#   type        = bool
#   default     = false
# }

# variable "resource_group_name" {
#   description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created"
#   default     = "myRG"
# }

# variable "resource_group_location" {
#   description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
#   default     = "westeurope"
# }

# variable "tags" {
#   description = "(Optional) A mapping of tags to assign to the resource"
#   type        = map(string)
#   default     = {}
# }

# variable "namespace_name" {
#   description = "Specifies the name of the ServiceBus Namespace resource . Changing this forces a new resource to be created"
#   default     = ""
# }

# variable "namespace_sku" {
#   description = "Defines which tier to use. Options are basic, standard or premium"
#   default     = "basic"
# }

# variable "namespace_capacity" {
#   description = "Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4 or 8. When sku is Basic or Standard, capacity can be 0 only"
#   default     = 0
# }

# variable "redundency" {
#   description = "Whether or not this resource is zone redundant. sku needs to be Premium. Defaults to false."
#   default     = false
# }


# # Resource_lock
# variable "servicebus_namespace_lock_name" {
#  description = "Service bus lock name"
#  default = "namespace_lock"  
# }

# variable "servicebus_namespace_lock_scope" {
#   description = "Namespace Lock scope"
#   default = ""
# }

# variable "servicebus_namespace_lock_level" {
#   description = "Namespace Lock level"
#   default = "CanNotDelete"
# }

# variable "servicebus_namespace_lock_notes" {
#   description = "Namespace lock notes"
#   default = ""
# }