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

#KEY VAULT RESOURCE GROUP VARIABLES
variable "key_vault_resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#KEY VAULT
variable "key_vault_variables" {
  description = "Map of object of key vault"
  type = map(object({
    key_vault_name                                  = string
    key_vault_resource_group_name                   = string
    key_vault_location                              = string
    key_vault_enabled_for_disk_encryption           = bool
    key_vault_enabled_for_deployment                = bool
    key_vault_enabled_for_template_deployment       = bool
    key_vault_enable_rbac_authorization             = bool
    key_vault_soft_delete_retention_days            = string
    key_vault_purge_protection_enabled              = bool
    key_vault_sku_name                              = string
    key_vault_access_container_agent_name           = string
    key_vault_access_policy_key_permissions         = list(string)
    key_vault_access_policy_secret_permissions      = list(string)
    key_vault_access_policy_storage_permissions     = list(string)
    key_vault_access_policy_certificate_permissions = list(string)
    key_vault_tags                                  = map(string)
    key_vault_network_acls_enabled                  = bool
    key_vault_network_acls_bypass                   = string
    key_vault_network_acls_default_action           = string
    key_vault_network_acls_ip_rules                 = list(string)
    key_vault_network_acls_virtual_networks = list(object({
      virtual_network_name    = string
      subnet_name             = string
      subscription_id         = string
      virtual_network_rg_name = string
    }))
    key_vault_contact_information_enabled = bool
    key_vault_contact_email               = string
    key_vault_contact_name                = string
    key_vault_contact_phone               = string
  }))
  default = {}
}

#Key vault key variables
variable "key_vault_key_variables" {
  description = "Map of object of key vault key"
  type = map(object({
    name                = string
    resource_group_name = string
    key_vault_name      = string
    key_type            = string
    key_size            = number
    curve               = string
    key_opts            = list(string)
    not_before_date     = string
    expiration_date     = string
    key_vault_key_tags  = map(string)
  }))
  default = {}
}

#USER ASSIGNED IDENTITY VARIABLES
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