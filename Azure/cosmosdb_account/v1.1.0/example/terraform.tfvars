#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg000005"
    location = "eastus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"

    }
  }
}
#RESOURCE GROUP 
key_vault_resource_group_variables = {
  "resource_group_2" = {
    name     = "ploceusrg000006"
    location = "eastus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"

    }
  }
}

#Subnets
subnet_variables = {
  "subnet_1" = {
    name                                           = "ploceussubnet000001a"
    resource_group_name                            = "ploceusrg000005"
    address_prefixes                               = ["10.0.1.0/24"]
    virtual_network_name                           = "ploceusvnet000001a"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = true #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  }
}

#VNET 
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001a"
    location                    = "eastus2"
    resource_group_name         = "ploceusrg000005"
    address_space               = ["10.0.0.0/16"]
    dns_servers                 = []
    flow_timeout_in_minutes     = null #possible values are between 4 and 30 minutes.
    bgp_community               = null
    edge_zone                   = null
    is_ddos_protection_required = false #Provide the value as true only if ddos_protection_plan is required
    ddos_protection_plan_name   = null  #Provide the name of the ddos protection plan if above value is true or else keep it as null. If new DDOS protection plan needs to be created uncomment from line 24 to 34
    vnet_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault0000017k"
    key_vault_location                              = "eastus2"
    key_vault_resource_group_name                   = "ploceusrg000006"
    key_vault_enabled_for_disk_encryption           = true
    key_vault_enabled_for_deployment                = true
    key_vault_enabled_for_template_deployment       = true
    key_vault_enable_rbac_authorization             = false
    key_vault_soft_delete_retention_days            = "7"
    key_vault_purge_protection_enabled              = true
    key_vault_sku_name                              = "standard"
    key_vault_access_container_agent_name           = null
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge", "Sign", "Verify", "Encrypt", "Decrypt", "UnwrapKey", "WrapKey", "Import", "Update"]
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]
    key_vault_access_policy_storage_permissions     = []
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
    key_vault_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled          = false
    key_vault_network_acls_bypass           = "AzureServices"
    key_vault_network_acls_default_action   = "Allow"
    key_vault_network_acls_ip_rules         = null
    key_vault_network_acls_virtual_networks = null
    key_vault_contact_information_enabled   = false
    key_vault_contact_email                 = "XXXXXXXXXXX@neudesic.com"
    key_vault_contact_name                  = "XXXXXXXXXXX"
    key_vault_contact_phone                 = "99999999999"

  }
}

#KEY VAULT KEY
key_vault_key_variables = {
  "key_vault_key_1" = {
    name                = "ploceuskeyavaultkey000001b"
    resource_group_name = "ploceusrg000006"
    key_vault_name      = "ploceuskeyvault0000017k"
    key_type            = "RSA"
    key_size            = 2048
    curve               = null
    key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    not_before_date     = null
    expiration_date     = null
    key_vault_key_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#cosmos account variables
cosmosdb_account_variables = {
  "cosmosdb_account_1" = {
    cosmosdb_account_access_key_metadata_writes_enabled    = true  #Default value is true
    cosmosdb_account_analytical_storage_enabled            = false #Default is false
    cosmosdb_account_assign_identity                       = true  #Default value is true
    cosmosdb_account_create_mode                           = null  #"Default" #`create_mode` only works when `backup.type` is `Continuous`
    cosmosdb_account_default_identity_type                 = null  #"SystemAssignedIdentity" #Cannot set SystemAssignedIdentity as the default identity during provision.
    cosmosdb_account_enable_automatic_failover             = true  #Default value is true
    cosmosdb_account_enable_free_tier                      = false #Default is false
    cosmosdb_account_enable_multiple_write_location        = false #Default is false
    cosmosdb_account_ip_range_filter                       = null  #CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account.
    cosmosdb_account_is_virtual_network_filter_enabled     = true  #Default is false
    cosmosdb_account_kind                                  = "MongoDB"
    cosmosdb_account_local_authentication_disabled         = false #Default is false
    cosmosdb_account_location                              = "eastus2"
    cosmosdb_account_mongo_server_version                  = "4.2" #Possible values are 4.2, 4.0, 3.6, and 3.2.
    cosmosdb_account_name                                  = "ploceuscdba000001"
    cosmosdb_account_network_acl_bypass_for_azure_services = false #Default is false
    cosmosdb_account_offer_type                            = "Standard"
    cosmosdb_account_public_network_access_enabled         = false #Default is false
    cosmosdb_account_resource_group_name                   = "ploceusrg000005"
    cosmosdb_account_subnet_name                           = "ploceussubnet000001a"
    cosmosdb_account_subnet_resource_group_name            = "ploceusrg000005"
    cosmosdb_account_subnet_virtual_network_name           = "ploceusvnet000001a"
    enable_restore                                         = false #for commented out the restore optional block
    enable_cors_rule                                       = false #for commented out the cors rule optional block
    cosmosdb_account_network_acl_bypass_ids                = null  #The list of resource Ids for Network Acl Bypass for this Cosmos DB account.
    cosmosdb_account_key_vault_name                        = "ploceuskeyvault0000017k"
    cosmosdb_account_key_vault_resource_group_name         = "ploceusrg000006"
    cosmosdb_account_key_vault_Key_name                    = "ploceuskeyavaultkey000001b"
    cosmosdb_account_object_id                             = "dc58ca33-570d-4f17-80f1-2ad7e760ecbc" # Provided cosmosdb provider object id.
    cosmosdb_account_key_permissions                       = ["Get", "UnwrapKey", "WrapKey", "List", "Update", "Import", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]
    cosmosdb_account_secret_permissions                    = ["Get"] #"List", "Delete", "Recover", "Backup", "Restore", "Purge"
    cosmosdb_account_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
    analytical_storage = {
      cosmosdb_account_analytical_storage_schema_type = "FullFidelity" # Possible values are FullFidelity and WellDefined.
    }
    backup = {
      cosmosdb_account_backup_interval_in_minutes = 60         #  Possible values are between 60 and 1440.
      cosmosdb_account_backup_retention_in_hours  = 8          # Possible values are between 8 and 720.
      cosmosdb_account_backup_storage_redundancy  = "Local"    #Possible values are Geo, Local and Zone.
      cosmosdb_account_backup_type                = "Periodic" # Possible values are Continuous and Periodic. Defaults to Periodic. Migration of Periodic to Continuous is one-way, changing Continuous to Periodic forces a new resource to be created.
    }
    capabilities = [{ #The capability to enable - Possible values are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL.
      cosmosdb_account_capabilities_name = "EnableAggregationPipeline"
      },
      {
        cosmosdb_account_capabilities_name = "mongoEnableDocLevelTTL"
      },
      {
        cosmosdb_account_capabilities_name = "MongoDBv3.4"
      },
      {
        cosmosdb_account_capabilities_name = "EnableMongo"
      }
    ]
    capacity = {
      cosmosdb_account_capacity_total_throughput_limit = -1 #Possible values are at least -1. -1 means no limit.
    }
    consistency_policy = {
      cosmosdb_account_consistency_policy_consistency_level       = "BoundedStaleness" #can be either BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix.
      cosmosdb_account_consistency_policy_max_interval_in_seconds = 310                #Accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency_level is set to BoundedStaleness.
      cosmosdb_account_consistency_policy_max_staleness_prefix    = 1000000            #Accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency_level is set to BoundedStaleness.
    }
    cors_rule = {
      cosmosdb_account_cors_rule_allowed_headers    = [] #A list of headers that are allowed to be a part of the cross-origin request.
      cosmosdb_account_cors_rule_allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"]
      cosmosdb_account_cors_rule_allowed_origins    = []  #A list of origin domains that will be allowed by CORS.
      cosmosdb_account_cors_rule_exposed_headers    = []  #A list of response headers that are exposed to CORS
      cosmosdb_account_cors_rule_max_age_in_seconds = 100 #The number of seconds the client should cache a preflight response.
    }
    geo_location = [
      {
        cosmosdb_account_geo_location_failover_priority = 0 # A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1).
        cosmosdb_account_geo_location_location          = "eastus"
        cosmosdb_account_geo_location_zone_redundant    = false #Defaults to false.
      },
      {
        cosmosdb_account_geo_location_failover_priority = 1 # A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1).
        cosmosdb_account_geo_location_location          = "eastus2"
        cosmosdb_account_geo_location_zone_redundant    = false #Defaults to false.
      }
    ]
    restore = {
      cosmosdb_account_restore_database_collection_names  = []   #A list of the collection names for the restore request.
      cosmosdb_account_restore_database_name              = null #The database name for the restore request. 
      cosmosdb_account_restore_restore_timestamp_in_utc   = null #Datetime Format RFC 3339
      cosmosdb_account_restore_source_cosmosdb_account_id = null #he resource ID of the restorable database account from which the restore has to be initiated.
    }
    virtual_network_rule = {
      cosmosdb_account_virtual_network_rule_ignore_missing_vnet_service_endpoint = false #Defaults to false.
    }
  }
}

cosmos_db_account_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
cosmos_db_account_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
key_vault_subscription_id         = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
key_vault_tenant_id               = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
