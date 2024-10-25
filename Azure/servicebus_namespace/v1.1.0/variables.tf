#Servicebus namespace variables
variable "servicebus_namespace_variables" {
  description = "Map of object of Servicebus namespace"
  type = map(object({
    servicebus_namespace_name                = string #(Required) Specifies the name of the ServiceBus Namespace resource . Changing this forces a new resource to be created.
    servicebus_namespace_resource_group_name = string #(Required) The name of the resource group in which to create the namespace.
    servicebus_namespace_location            = string #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    servicebus_namespace_sku                 = string # (Required) Defines which tier to use. Options are Basic, Standard or Premium. Please note that setting this field to Premium will force the creation of a new resource.
    servicebus_namespace_identity = object({          #(Optional) An identity block as defined below.
      identity_type = string                          #(Required) Specifies the type of Managed Service Identity that should be configured on this ServiceBus Namespace. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_user_assigned_identities = list(object({
        user_assigned_identities_name                = string #(Optional) User assigned identity name. Provide value only if "identity_type" is set to UserAssigned or SystemAssigned, UserAssigned
        user_assigned_identities_resource_group_name = string #(Optional) User assigned identity resource group name. Provide value only if "identity_type" is set to UserAssigned or SystemAssigned, UserAssigned
      }))
    })
    servicebus_namespace_capacity = number #(Optional) Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4, 8 or 16. When sku is Basic or Standard, capacity can be 0 only.
    servicebus_namespace_customer_managed_key = object({
      customer_managed_key_infrastructure_encryption_enabled = bool #(Optional) Used to specify whether enable Infrastructure Encryption (Double Encryption).
    })
    servicebus_namespace_local_auth_enabled               = bool        #(Optional) Whether or not SAS authentication is enabled for the Service Bus namespace. Defaults to true.
    servicebus_namespace_zone_redundant                   = bool        #(Optional) Whether or not this resource is zone redundant. sku needs to be Premium. Defaults to false.
    servicebus_namespace_is_customer_managed_key_required = bool        #(Required)Provide boolean value to check the condition
    servicebus_namespace_key_vault_name                   = string      #(Optional)Key vault name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_key_vault_resource_group_name    = string      #(Optional)Key vault resource group name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_key_vault_key_name               = string      #(Optional)Key vault key name. Provide value only if "servicebus_namespace_is_customer_managed_key_required" is set to "true"
    servicebus_namespace_tags                             = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default = {}
}