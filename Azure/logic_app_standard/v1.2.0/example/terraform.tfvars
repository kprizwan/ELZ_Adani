#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#key_vault_resource_group 
key_vault_resource_group_variables = {
  "resource_group_2" = {
    resource_group_name     = "ploceusrg000002" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#User Assigned Identity VARIABLES
user_assigned_identity_variables = {
  "user_assigned_identity_1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "eastus"           # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000001"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    } #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
  },
  "user_assigned_identity_2" = {
    user_assigned_identity_name                = "ploceusuai000002" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "eastus"           # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000001"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
    user_assigned_identity_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    } #(Optional) A mapping of tags which should be assigned to the User Assigned Identity.
  }
}
#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus"                                                                                                                                                                                        #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = true                                                                                                                                                                                            #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                      #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                                                                                                                                                                                            #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                            #(Optional) The object ID of an Application in Azure Active Directory.                                                                                                                                                                        
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                            #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                              #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Deny"          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  }
}
#KEY VAULT ACCESS POLICY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge"]                                                                                                                    #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                       #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                              #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"] #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskeyvault000001"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                               #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxx.xxxxx@ploceus.com"                                                                                                                                                                       #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name
    key_vault_access_resource_type                  = "User"                                                                                                                                                                                          #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}
#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskeyvault000001"   #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = "ploceusconnstring000001" #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                        #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                      #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                      #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"         #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceusconnstring000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_tags = {                                        #(Optional) A mapping of tags which should be assigned to the key vault secret. 
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }
}
# KAY VAULT KEY 
key_vault_key_variables = {
  "key_vault_key_01" = {
    key_vault_name                = "ploceuskeyvault000001"                                          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = "ploceusrg000002"                                                #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = "ploceuskvkey000001"                                             #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = "RSA"                                                            #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = 2048                                                             #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = null                                                             #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"] #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = "2023-01-05T18:15:30Z"                                           #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = "2023-05-05T18:15:30Z"                                           #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_tags = {                                                                           #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}
#Virtual Network 
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001" #(Required) The name of the virtual network.
    virtual_network_location                = "eastus"            #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"   #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]     #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                      #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false           #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = null            #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_subnet = null
    virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#Subnets
subnet_variables = {
  "subnet_1" = {
    subnet_name                                           = "ploceussubnet000001"                                   # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000001"                                       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.0.3.0/24"]                                         #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                           = "ploceusvnet000001"                                     #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled  = null                                                    # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = null                                                    # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_enforce_private_link_endpoint_network_policies = null                                                    #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = null                                                    #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = null                                                    #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                              = ["Microsoft.AzureActiveDirectory", "Microsoft.Storage"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000001"                                        #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Web/serverFarms"                               # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  },
  "subnet_2" = {
    subnet_name                                           = "ploceussubnet000002"                       # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = "ploceusrg000001"                           #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = ["10.0.4.0/24"]                             #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                           = "ploceusvnet000001"                         #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled  = null                                        # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled      = null                                        # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_enforce_private_link_endpoint_network_policies = null                                        #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_enforce_private_link_service_network_policies  = null                                        #(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false.
    subnet_service_endpoint_policy_ids                    = null                                        #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                              = ["Microsoft.KeyVault", "Microsoft.Storage"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000002"                                        #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Web/serverFarms"                               # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  }
}
# STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_01" = {
    storage_account_key_vault_name                                     = "ploceuskeyvault000001" #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = "ploceusrg000002"       #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = "ploceuskvkey000001"    #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = "ploceusuai000001"      #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = "ploceusrg000001"       #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = "SystemAssigned"        #(Required) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "ploceusstracc000001"   #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "ploceusrg000001"       #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "eastus"                #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = "StorageV2"             #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"              #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"                   #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true                    #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"                   #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null                    #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = null                    #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"                #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = null                    #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = null                    #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true                    #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = null                    #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = null                    #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = null                    #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false                   #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"               #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"               #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = null                    #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_custom_domain                                      = null
    storage_account_identity                                           = null
    storage_account_blob_properties                                    = null
    storage_account_queue_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }
      logging_enabled = true #Should storage account queue properties logging be enabled.
      logging = {
        delete                = true  #(Required) Indicates whether all delete requests should be logged. 
        read                  = true  #(Required) Indicates whether all read requests should be logged. 
        version               = "1.0" #(Required) The version of storage analytics to configure.
        write                 = true  #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
      minute_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = "1.0" #(Required) The version of storage analytics to configure. 
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
      hour_metrics = {
        enabled               = true  #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = "1.0" #(Required) The version of storage analytics to configure. 
        include_apis          = true  #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = 7     #(Optional) Specifies the number of days that logs will be retained.
      }
    }
    storage_account_static_website = {
      index_document     = "index.html" #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = "404.html"   #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    }
    storage_account_share_properties           = null
    storage_account_network_rules              = null
    storage_account_azure_files_authentication = null
    # storage_account_azure_files_authentication = {  # Use this block when need to authenticate with Azure active directory domain services or Active Directory.
    #   directory_type = "AADDS" #(Required) Specifies the directory service used. Possible values are AADDS and AD.
    #   active_directory = {
    #     storage_sid         = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID) for Azure Storage.
    #     domain_name         = "www.ploceus1.com" #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
    #     domain_sid          = "xxxxxxxxxx" #(Required) Specifies the security identifier (SID).
    #     domain_guid         = "xxxxxxxxxx" #(Required) Specifies the domain GUID.
    #     forest_name         = "xxxxxxxxxx" #(Required) Specifies the Active Directory forest.
    #     netbios_domain_name = "www.ploceus2.com" #(Required) Specifies the NetBIOS domain name.
    #   }
    # }
    storage_account_routing = {
      publish_internet_endpoints  = false              #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false              #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "MicrosoftRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }
    storage_account_immutability_policy = {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    }
    storage_account_sas_policy = {
      expiration_period = "11:12:13:14" #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = "Log"         #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    }
    storage_account_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}
#APP SERVICE PLAN
app_service_plan_variables = {
  "app_service_plan_1" = {
    app_service_plan_name                          = "ploceusappplan000001" #(Required) The name which should be used for this Service Plan. Changing this forces a new AppService to be created.
    app_service_plan_location                      = "eastus"               #(Required) The Azure Region where the Service Plan should exist. Changing this forces a new AppService to be created.
    app_service_plan_os_type                       = "Windows"              #(Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer.
    app_service_plan_resource_group_name           = "ploceusrg000001"      #(Required) The name of the Resource Group where the AppService should exist. Changing this forces a new AppService to be created.
    app_service_plan_sku_name                      = "WS1"                  # (Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1.#Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments #Elastic and Consumption SKUs (Y1, EP1, EP2, and EP3) are for use with Function Apps.
    app_service_plan_maximum_elastic_worker_count  = null                   #(Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU.
    app_service_plan_worker_count                  = null                   #(Optional) The number of Workers (instances) to be allocated.
    app_service_plan_per_site_scaling_enabled      = false                  #(Optional) Should Per Site Scaling be enabled. Defaults to false.
    app_service_plan_zone_balancing_enabled        = false                  #(Optional) Should the Service Plan balance across Availability Zones in the region. Defaults to false. If this setting is set to true and the worker_count value is specified, it should be set to a multiple of the number of availability zones in the region. Please see the Azure documentation for the number of Availability Zones in your region.
    app_service_environment_name                   = null                   #(Optional) Name of the app service environemnt Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3
    app_service_environment_resource_group_name    = null                   #(Optional) Resource Group Name of the app service environemnt
    app_service_environment_v3_name                = null                   #(Optional) Name of the app service environemnt Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3
    app_service_environment_v3_resource_group_name = null                   #(Optional) Resource Group Name of the app service environemnt 
    app_service_plan_tags = {                                               # (Optional) A mapping of tags which should be assigned to the AppService.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#Logic App Standard Variables
logic_app_standard_variables = {
  "logic_app_standard_variables_1" = {
    logic_app_standard_resource_group_name                  = "ploceusrg000001"        #(Required) The name of the resource group in which to create the Logic App
    logic_app_standard_storage_account_name                 = "ploceusstracc000001"    #(Required) The backend storage account name which will be used by this Logic App (e.g. for Stateful workflows data)
    logic_app_standard_storage_account_resource_group_name  = "ploceusrg000001"        #(Required) The resource group name of the storage account.
    logic_app_standard_app_service_plan_resource_group_name = "ploceusrg000001"        #(Required) The resource group name of the app service plan.
    logic_app_standard_location                             = "eastus"                 #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    logic_app_standard_app_service_plan_name                = "ploceusappplan000001"   #(Required) The name of the app service plan.
    logic_app_standard_name                                 = "ploceuslogappstd000001" #(Required) Specifies the name of the Logic App Changing this forces a new resource to be created.
    logic_app_standard_app_settings                         = null                     #(Optional) A map of key-value pairs for App Settings and custom values.
    logic_app_standard_use_extension_bundle                 = true                     #(Optional) Should the logic app use the bundled extension package? If true, then application settings for AzureFunctionsJobHost__extensionBundle__id and AzureFunctionsJobHost__extensionBundle__version will be created. Default true
    logic_app_standard_bundle_version                       = "[1.*,2.0.0)"            #(Optional) If use_extension_bundle then controls the allowed range for bundle versions. Default [1.*, 2.0.0)
    is_connection_string_required                           = false                    #(Optional) possible values are true and false
    logic_app_standard_connection_string                    = null /* {                                           #(Optional)
      name = "ploceuslaconnstring000001"                                               #(Required) The name of the Connection String.
      type = "SQLServer"                                                               #(Required)Possible values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer.
    }*/
    logic_app_standard_client_affinity_enabled              = null  #(Optional) Should the Logic App send session affinity cookies, which route client requests in the same session to the same instance?
    logic_app_standard_client_certificate_mode              = null  #(Optional) The mode of the Logic App's client certificates requirement for incoming requests. Possible values are Required and Optional.
    logic_app_standard_enabled                              = false #(Optional) Is the Logic App enabled?, possible values are true and false
    logic_app_standard_https_only                           = false #(Optional) Can the Logic App only be accessed via HTTPS? Defaults to false.
    logic_app_standard_identity = {                                 #(Optional)
      logic_app_standard_identity_type = "UserAssigned"             # (Required) Specifies the type of Managed Service Identity that should be configured on this logic app standard. Possible values are SystemAssigned, UserAssigned.
      # Possible values are SystemAssigned, UserAssigned 
      # If given as "SystemAssigned" , then give below parameter as null
      logic_app_standard_user_assigned_identities = [{                            #Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Logic App Standard.
        logic_app_standard_user_identity_name                = "ploceusuai000002" # (Optional) Specifies a User Assigned Managed Identity Name to be assigned to this Logic App standard.
        logic_app_standard_user_identity_resource_group_name = "ploceusrg000001"  # (Optional) Specifies a User Assigned Managed Identity Resource group Name to be assigned to this Logic App standard.
      }]
    }
    is_subnet_required                                     = true #(Optional) Variable to ask user whether subnet is required
    logic_app_standard_site_config                         = null /*[{ #(Optional)
      always_on       = false           #(Optional) Should the Logic App be loaded at all times? Defaults to false.
      app_scale_limit = null            #(Optional) The number of workers this Logic App can scale out to. Only applicable to apps on the Consumption and Premium plan.
      cors = [{                         #(Optional)
        allowed_origins     = ["*"]     #(Optional) A list of origins which should be able to make cross-origin calls. * can be used to allow all calls.
        support_credentials = false     #(Optional) Are credentials supported?
      }]
      dotnet_framework_version         = null  #(Optional) The version of the .NET framework's CLR used in this Logic App Possible values are v4.0 (including .NET Core 2.1 and 3.1), v5.0 and v6.0. For more information on which .NET Framework version to use based on the runtime version you're targeting - please see this table. Defaults to v4.0.
      elastic_instance_minimum         = null  #(Optional) The number of minimum instances for this Logic App Only affects apps on the Premium plan.
      ftps_state                       = null  #(Optional) State of FTP / FTPS service for this Logic App Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to AllAllowed.
      health_check_path                = null  #(Optional) Path which will be checked for this Logic App health.
      http2_enabled                    = false #(Optional) Specifies whether or not the HTTP2 protocol should be enabled. Defaults to false.
      ip_restriction                   = [{       #(Optional) 
        ip_address  = null               #(Optional) The IP Address used for this IP Restriction in CIDR notation.
        service_tag = null               #(Optional) The Service Tag used for this IP Restriction.
        name        = null               #(Optional) The name for this IP Restriction.
        priority    = null               # (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.
        action      = null               #(Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow.
        headers = {                 #(Optional)
          x_azure_fdid      = null #(Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.
          x_fd_health_probe = null #(Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".
          x_forwarded_for   = null #(Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8
          x_forwarded_host  = null #(Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.
        }
      }]
      linux_fx_version                 = null  #(Optional) Linux App Framework and version for the AppService, e.g. DOCKER|(golang:latest). Setting this value will also set the kind of application deployed to functionapp,linux,container,workflowapp
      min_tls_version                  = null  #(Optional) The minimum supported TLS version for the Logic App Possible values are 1.0, 1.1, and 1.2. Defaults to 1.2 for new Logic Apps.
      pre_warmed_instance_count        = null  #(Optional) The number of pre-warmed instances for this Logic App Only affects apps on the Premium plan.
      runtime_scale_monitoring_enabled = false #(Optional) Should Runtime Scale Monitoring be enabled?. Only applicable to apps on the Premium plan. Defaults to false.
      use_32_bit_worker_process        = true  #(Optional) Should the Logic App run in 32 bit mode, rather than 64 bit mode? Defaults to true.
      vnet_route_all_enabled           = false #(Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.
      websockets_enabled               = false #(Optional) Should WebSockets be enabled?
      scm_ip_restriction               = [{   #(Optional) 
        ip_address  = null               #(Optional) The IP Address used for this IP Restriction in CIDR notation.
        service_tag = null               #(Optional) The Service Tag used for this IP Restriction.
        name        = null               #(Optional) The name for this IP Restriction.
        priority    = null               #(Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.
        action      = null               #(Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow.
        headers = {                 #(Optional)
          x_azure_fdid      = null #(Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.
          x_fd_health_probe = null #(Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".
          x_forwarded_for   = null #(Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8
          x_forwarded_host  = null #(Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.
        }
      }]
      scm_use_main_ip_restriction      = false #(Optional) Should the Logic App ip_restriction configuration be used for the SCM too. Defaults to false.
      scm_min_tls_version              = null  #(Optional) Configures the minimum version of TLS required for SSL requests to the SCM site.
      scm_type                         = null  #The type of Source Control used by the Logic App in use by the Windows Function App. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM
    }]*/
    storage_account_share_name_required                    = false
    logic_app_standard_storage_account_share_name          = null                      #"ploceussashare000001"    #(Optional) The name of the share used by the logic app, if you want to use a custom name. This corresponds to the WEBSITE_CONTENTSHARE appsetting, which this resource will create for you. If you don't specify a name, then this resource will generate a dynamic name. This setting is useful if you want to provision a storage account and create a share using azurerm_storage_share
    logic_app_standard_version                             = null                      #(Optional) The runtime version associated with the Logic App Defaults to ~1.
    logic_app_standard_key_vault_name                      = "ploceuskeyvault000001"   #(Required) The name of the key vault.
    logic_app_standard_key_vault_resource_group_name       = "ploceusrg000002"         #(Required) The resource group name of the app service plan.
    logic_app_standard_secret_connection_string_value_name = "ploceusconnstring000001" #(Required) The value for the Connection String.
    logic_app_standard_subnet_name                         = "ploceussubnet000001"     #(Required) The name of the subnet.
    logic_app_standard_vnet_name                           = "ploceusvnet000001"       #(Required) The name of the vnet.
    logic_app_standard_subnet_resource_group_name          = "ploceusrg000001"         #(Required) The resource group name of the subnet.
    logic_app_standard_tags = {                                                        #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
logic_app_standard_subscription_id = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
logic_app_standard_tenant_id       = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
key_vault_subscription_id          = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
key_vault_tenant_id                = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"