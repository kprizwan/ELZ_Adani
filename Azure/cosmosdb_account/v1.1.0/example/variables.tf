#RESORCE GROUP VARIABLE
variable "resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}
#RESORCE GROUP VARIABLE
variable "key_vault_resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

# cosmos db account variables
variable "cosmosdb_account_variables" {
  type = map(object({
    cosmosdb_account_name                                  = string
    cosmosdb_account_location                              = string
    cosmosdb_account_resource_group_name                   = string
    cosmosdb_account_offer_type                            = string
    cosmosdb_account_kind                                  = string
    cosmosdb_account_enable_automatic_failover             = bool
    cosmosdb_account_create_mode                           = string
    cosmosdb_account_ip_range_filter                       = string
    cosmosdb_account_enable_free_tier                      = bool
    cosmosdb_account_analytical_storage_enabled            = bool
    cosmosdb_account_public_network_access_enabled         = bool
    cosmosdb_account_is_virtual_network_filter_enabled     = bool
    cosmosdb_account_enable_multiple_write_location        = bool
    cosmosdb_account_access_key_metadata_writes_enabled    = bool
    cosmosdb_account_mongo_server_version                  = string
    cosmosdb_account_network_acl_bypass_for_azure_services = bool
    cosmosdb_account_local_authentication_disabled         = bool
    cosmosdb_account_default_identity_type                 = string
    cosmosdb_account_subnet_name                           = string
    cosmosdb_account_subnet_virtual_network_name           = string
    cosmosdb_account_subnet_resource_group_name            = string
    cosmosdb_account_assign_identity                       = bool
    cosmosdb_account_tags                                  = map(string)
    enable_restore                                         = bool
    enable_cors_rule                                       = bool
    cosmosdb_account_network_acl_bypass_ids                = list(string)
    cosmosdb_account_key_vault_name                        = string
    cosmosdb_account_key_vault_resource_group_name         = string
    cosmosdb_account_key_vault_Key_name                    = string
    cosmosdb_account_object_id                             = string
    cosmosdb_account_key_permissions                       = list(string)
    cosmosdb_account_secret_permissions                    = list(string)
    virtual_network_rule = object({
      cosmosdb_account_virtual_network_rule_ignore_missing_vnet_service_endpoint = bool
    })
    analytical_storage = object({
      cosmosdb_account_analytical_storage_schema_type = string
    })
    capacity = object({
      cosmosdb_account_capacity_total_throughput_limit = number
    })
    backup = object({
      cosmosdb_account_backup_type                = string
      cosmosdb_account_backup_interval_in_minutes = number
      cosmosdb_account_backup_retention_in_hours  = number
      cosmosdb_account_backup_storage_redundancy  = string
    })
    cors_rule = object({
      cosmosdb_account_cors_rule_allowed_headers    = list(string)
      cosmosdb_account_cors_rule_allowed_methods    = list(string)
      cosmosdb_account_cors_rule_allowed_origins    = list(string)
      cosmosdb_account_cors_rule_exposed_headers    = list(string)
      cosmosdb_account_cors_rule_max_age_in_seconds = number
    })
    restore = object({
      cosmosdb_account_restore_source_cosmosdb_account_id = string
      cosmosdb_account_restore_restore_timestamp_in_utc   = string
      cosmosdb_account_restore_database_name              = string
      cosmosdb_account_restore_database_collection_names  = list(string)
    })
    capabilities = list(object({
      cosmosdb_account_capabilities_name = string
    }))
    consistency_policy = object({
      cosmosdb_account_consistency_policy_consistency_level       = string
      cosmosdb_account_consistency_policy_max_interval_in_seconds = number
      cosmosdb_account_consistency_policy_max_staleness_prefix    = number
    })
    geo_location = list(object({
      cosmosdb_account_geo_location_location          = string
      cosmosdb_account_geo_location_failover_priority = number
      cosmosdb_account_geo_location_zone_redundant    = bool
    }))
  }))
}

#Subnet Variables
variable "subnet_variables" {
  type = map(object({
    name                                           = string
    resource_group_name                            = string
    virtual_network_name                           = string
    address_prefixes                               = list(string)
    enforce_private_link_service_network_policies  = bool
    enforce_private_link_endpoint_network_policies = bool
    service_endpoints                              = list(string)
    is_delegetion_required                         = bool
    delegation_name                                = string
    service_name                                   = string
    service_actions                                = list(string)
  }))
  default = {}
}

#VNET variable
variable "vnets_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    address_space               = list(string)
    dns_servers                 = list(string)
    flow_timeout_in_minutes     = number
    bgp_community               = string
    is_ddos_protection_required = bool
    ddos_protection_plan_name   = string
    vnet_tags                   = map(string)
    edge_zone                   = string
  }))
  default = {}
}

#KEY VAULT
variable "key_vault_variables" {
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
}
variable "key_vault_key_variables" {
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
}
