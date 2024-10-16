# CONTAINER REGISTRY VARIABLES
variable "container_registry_variables" {
  type = map(object({
    container_registry_name                   = string #  (Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_resource_group_name    = string #   (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_location               = string # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_sku                    = string # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled          = bool   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_georeplication_enabled = bool   #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications = list(object({
      georeplications_location                  = string      # (Required) A location where the container registry should be geo-replicated.
      georeplications_regional_endpoint_enabled = bool        # (Optional) Whether regional endpoint is enabled for this Container Registry? Defaults to false.
      georeplications_zone_redundancy_enabled   = bool        # (Optional) Whether zone redundancy is enabled for this replication location? Defaults to false.
      georeplications_tags                      = map(string) # (Optional) A mapping of tags to assign to this replication location.
    }))
    container_registry_network_rule_set_enabled = bool #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = object({
      network_rule_set_default_action = string #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule = list(object({ #(Optional) Block for ip_rue set.  set to null if ip rules are not required
        ip_rule_action   = string              # (Required) The behaviour for requests matching this rule. At this time the only supported value is Allow
        ip_rule_ip_range = string              # (Required) The CIDR block from which requests will match the rule.
      }))
      network_rule_set_virtual_network = list(object({ #(Optional) Block for ip_rue set.  set to null if network_rule_set rules are not required
        virtual_network_action               = string  # (Required) The behaviour for requests matching this rule. At this time the only supported value is Allow
        virtual_network_virtual_network_name = string  # (Required) The name of  virtual network name 
        virtual_network_subnet_name          = string  # (Required) The name of subnet
        virtual_network_resource_group_name  = string  # (Required) The resource group name of Virtual network
      }))
    })
    container_registry_public_network_access_enabled = bool # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = bool # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_retention_policy = object({
      retention_policy_days    = number # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = bool   # (Optional) Boolean value that indicates whether the policy is enabled.

    })
    container_registry_trust_policy = object({
      trust_policy_enabled = bool #  (Optional) Boolean value that indicates whether the policy is enabled.
    })
    container_registry_zone_redundancy_enabled = bool # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_export_policy_enabled   = bool # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_identity = object({
      identity_type = string # (Required) Specifies the type of Managed Service Identity that should be configured on this Container Registry. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_identity_ids = list(object({
        identity_ids_identity_name                = string # (Required) The Name of the managed identity
        identity_ids_identity_resource_group_name = string # (Required) The name of resource group where identity is created.
      }))
    })

    container_registry_encryption = object({
      encryption_enabled                      = bool   #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_identity_name                = string # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = string # (Required) The name of resource group where identity is created.
      encryption_keyvault_name                = string # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = string # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = string #(Required) # Resource group of the KeyVault
    })
    container_registry_anonymous_pull_enabled = bool # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_data_endpoint_enabled  = bool # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.

    container_registry_network_rule_bypass_option = string # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.

    container_registry_tags = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of object of container registry variables."
  default     = {}
}
