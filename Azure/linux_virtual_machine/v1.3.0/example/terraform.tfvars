#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP FOR KEY VAULT
key_vault_resource_group_variables = {
  "resource_group_2" = {
    resource_group_name       = "ploceusrg000002" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL NETWORK 
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "ploceusvnet000001"         #(Required) The name of the virtual network.
    virtual_network_location                = "eastus"                    #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/16"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_encryption = null /*[
      {
        virtual_network_encryption_enforcement = "AllowUnencrypted"
      }
    ] */
    virtual_network_subnet     = null /*[ #(Optional) Can be specified multiple times to define multiple subnets
      {
        virtual_network_subnet_name                                       = "ploceussubnet000001" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.0.0.0/24"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null    #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null     #(Optional) The Network Security Group to associate with the subnet.
      }
    ] */
    virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#DDOS plan creation is optional and costly. Uncommenting  will create a new DDOS protection plan. Use only if required. 
# network_ddos_protection_plan_variables = {
#   "ddos_plan_1" = {
#     network_ddos_protection_plan_name                = "ploceusddosplan000001" #(Required) Specifies the name of the Network DDoS Protection Plan. 
#     network_ddos_protection_plan_location            = "eastus"               #(Required) The name of the resource group in which to create the resource.
#     network_ddos_protection_plan_resource_group_name = "ploceusrg000001"       #(Required) Specifies the supported Azure location where the resource exists.
#     #(Optional) A mapping of tags which should be assigned to the DDOS protection plan
#     network_ddos_protection_plan_tags = {
#       Created_By = "Ploceus",
#       Department = "CIS"
#     }
#   }
# }

#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                          = "ploceussubnet000001"                                    # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "ploceusrg000001"                                        #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.0.3.0/24"]                                          #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "ploceusvnet000001"                                      #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                                                     # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                                                     # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                                                     #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = ["Microsoft.AzureActiveDirectory", "Microsoft.KeyVault"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = [{
      delegation_name            = "delegation000001"                                                                                                                                                                                                #(Required) A name for this delegation.
      service_delegation_name    = "Microsoft.Sql/managedInstances"                                                                                                                                                                                  # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }]
  }
}

#PUBLIC IP
public_ip_variables = {
  "public_ip_1" = {
    public_ip_name                                     = "ploceuspublicip000001"  # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = "ploceusrg000001"        # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = "eastus"                 # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = "IPv4"                   # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = "Static"                 # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = "Standard"               # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = "Regional"               # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_domain_name_label                        = "ploceuspublicip000002a" # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_prefix_id                                = null                     #  (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_idle_timeout_in_minutes                  = "30"                     # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_zones                                    = ["1", "3"]               # (Optional) A collection containing the availability zone to allocate the Public IP in.
    public_ip_edge_zone                                = null                     # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
    public_ip_reverse_fqdn                             = null                     # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
    public_ip_ip_tags                                  = null                     # (Optional) A mapping of IP tags to assign to the public IP.
    public_ip_is_ddos_protection_plan_enabled          = false                    # (Required) True if ddos_protection_plan enabled, else false
    public_ip_ddos_protection_plan_name                = "ploceusddospplan000001" # (Optional) The Name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_plan_resource_group_name = "ploceusrg000001"        # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_mode                     = "Disabled"               # (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
    public_ip_tags = {                                                            # (Optional) Public IP tags
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#USER ASSIGNED IDENTITY
user_assigned_identity_variables = {
  "user_assigned_identity_1" = {
    user_assigned_identity_name                = "ploceusuai000001" #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = "eastus"           # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = "ploceusrg000001"  #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags = {                                 #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#LB
lb_variables = {
  "lb1" = {
    lb_edge_zone = null #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    lb_frontend_ip_configuration = {
      "config1" = {
        frontend_ip_configuration_gateway_lb_frontend_ip_configuration_id = { #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
          gateway_lb_name                = null                               # gateway load balancer name
          gateway_lb_resource_group_name = null                               # gateway load balancer resource group name
        }
        frontend_ip_configuration_name                          = "ploceusconfig000001" #(Required) Specifies the name of the frontend IP configuration.
        frontend_ip_configuration_private_ip_address            = "10.0.3.4"            # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
        frontend_ip_configuration_private_ip_address_allocation = "Static"              #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
        frontend_ip_configuration_private_ip_address_version    = "IPv4"                #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
        frontend_ip_configuration_public_ip_address_id = {                              #(Optional) The ID of a Public IP Address which should be associated with the Load Balancer.
          public_ip_name                = null                                          # public ip name
          public_ip_resource_group_name = null                                          # public ip resource group name
        }
        frontend_ip_configuration_public_ip_prefix_id = { #(Optional) The ID of a Public IP Prefix which should be associated with the Load Balancer. Public IP Prefix can only be used with outbound rules.
          public_ip_prefix_name                = null     # public ip prefix name
          public_ip_prefix_resource_group_name = null     # public ip prefix resource group name
        }
        frontend_ip_configuration_subnet = {
          subnet_name                    = "ploceussubnet000001" # Subnet name
          subnet_virtual_network_name    = "ploceusvnet000001"   # virtual network name where subnet resides.
          virtual_network_resource_group = "ploceusrg000001"     # Resource group name where the virtual network resides.
        }
        frontend_ip_configuration_zones = null #(Optional) Specifies a list of Availability Zones in which the IP Address for this Load Balancer should be located. Changing this forces a new Load Balancer to be created.
      }
    }
    lb_location            = "eastus"          # (Required) Specifies the supported Azure Region where the Load Balancer should be created.
    lb_name                = "ploceuslb00001"  #(Required) Specifies the name of the Load Balancer.
    lb_resource_group_name = "ploceusrg000001" # (Required) The name of the Resource Group in which to create the Load Balancer.
    lb_sku                 = "Basic"           #(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    lb_sku_tier            = "Regional"        #(Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    lb_tags = {
      "Created_By" = "Ploceus"
      Department   = "CIS"
    }
  }
}

#KEY VAULT FOR SSH KEYS
key_vault_variables_ssh_keys = {
  "key_vault_ssh_keys_1" = {
    key_vault_name                                  = "ploceuskv000001"                                                                                                                                                                                 #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus"                                                                                                                                                                                          #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                 #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                              #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                              #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                              # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                             #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                               #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = true                                                                                                                                                                                              #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                        #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                                                                                                                                                                                              #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                              #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                              #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Backup", "Restore", "Purge", "UnwrapKey", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                         #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]                                                  #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]   # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled        = false             #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices"   #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Deny"            # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = ["137.97.112.56"] # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null /*[ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    = "ploceusvnet000001"                      #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             = "ploceussubnet000001"                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         = "1f727cb9-164c-4873-855d-373e14ed3ff6" #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name = "ploceusrg000001"                        #(Required) Resource group where Vnet is created.
      }
    ] */
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  }
}

#KEY VAULT FOR DISK ENCRYPTION
key_vault_variables_disk_encryption = {
  "key_vault_disk_encryption_1" = {
    key_vault_name                                  = "ploceuskv000002"                                                                                                                                                                                 #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "eastus"                                                                                                                                                                                          #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                 #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                              #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                              #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                              # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                             #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                               #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = true                                                                                                                                                                                              #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = "standard"                                                                                                                                                                                        #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = null                                                                                                                                                                                              #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = null                                                                                                                                                                                              #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = true                                                                                                                                                                                              #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Backup", "Restore", "Purge", "UnwrapKey", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                         #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]                                                  #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]   # (Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_tags = { #(Optional) A mapping of tags which should be assigned to the key vault.
      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_network_acls_enabled        = false           #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Deny"          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = []              # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = null /*[ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    = "ploceusvnet000001"                      #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             = "ploceussubnet000001"                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         = "1f727cb9-164c-4873-855d-373e14ed3ff6" #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name = "ploceusrg000001"                        #(Required) Resource group where Vnet is created.
      }
    ]*/
    key_vault_contact_information_enabled   = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email                 = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                  = null  #(Optional) Name of the contact.
    key_vault_contact_phone                 = null  #(Optional) Phone number of the contact.

  }
}

#KEY VAULT ACCESS POLICY FOR ADMIN SSH KEY
key_vault_access_policy_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Backup", "Restore", "Purge", "UnwrapKey", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                         #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                                #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]   #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskv000001"                                                                                                                                                                                 #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                 #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxx@nploceus.com"                                                                                                                                                                             #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name

    key_vault_access_resource_type = "User" #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

#KEY VAULT ACCESS POLICY FOR DISK ENCRYPTION
key_vault_access_policy_disk_variables = {
  "key_vault_access_policy_1" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Backup", "Restore", "Purge", "UnwrapKey", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                         #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                                #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]   #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskv000002"                                                                                                                                                                                 #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                 #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "ploceusuai000001"                                                                                                                                                                                #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name

    key_vault_access_resource_type = "SPN" #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  },
  "key_vault_access_policy_2" = {
    key_vault_access_policy_key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Backup", "Restore", "Purge", "UnwrapKey", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"] #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = ["Get", "List", "Delete", "Recover", "Backup", "Restore", "Purge", "Set"]                                                                                                                         #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = []                                                                                                                                                                                                #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]   #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = "ploceuskv000002"                                                                                                                                                                                 #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = "ploceusrg000002"                                                                                                                                                                                 #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = "xxxxxx@ploceus.com"                                                                                                                                                                              #(Required) Specifies the resource name that needs an access policy to the key vault. Possible values are username, group name, service principal name and application name

    key_vault_access_resource_type = "User" #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }
}

#KEY VAULT KEY 
key_vault_key_variables = {
  "key_vault_key_01" = {
    key_vault_name                = "ploceuskv000002"                                                #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = "ploceusrg000002"                                                #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = "ploceuskvkey000001"                                             #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = "RSA"                                                            #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = 2048                                                             #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = null                                                             #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"] #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = "2023-01-05T18:15:30Z"                                           #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = "2023-05-05T18:15:30Z"                                           #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_rotation_policy = {                                                                #(Optional) A rotation_policy block as defined below.
      rotation_policy_expire_after         = "P90D"                                                  #(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration.
      rotation_policy_notify_before_expiry = "P29D"                                                  #(Optional) Notify at a given duration before expiry as an ISO 8601 duration. Default is P30D.
      rotation_policy_automatic = {                                                                  #(Optional) An automatic block as defined below.
        automatic_time_after_creation = "P50D"                                                       #(Optional) Rotate automatically at a duration after create as an ISO 8601 duration.
        automatic_time_before_expiry  = "P30D"                                                       #(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration.
      }
    }
    key_vault_key_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#KEY VAULT SECRET
key_vault_secret_variables = {
  "key_vault_secret_1" = {
    key_vault_name                       = "ploceuskv000001"       #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = ""                      #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                      #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                    #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                    #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"       #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskvsecret000001" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created


    key_vault_secret_tags = { #(Optional) A mapping of tags which should be assigned to the key vault secret. 

      Created_By = "Ploceus",
      Department = "CIS"
    }
    key_vault_secret_min_upper   = 10 #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower   = 5  #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric = 5  #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special = 3  #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length      = 32 #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  },
  "key_vault_secret_2" = {
    key_vault_name                       = "ploceuskv000002"       #(Required) Specifies the name of the Key Vault.
    key_vault_secret_value               = ""                      #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = ""                      #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = null                    #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_expiration_date     = null                    #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z'), value format example "1982-12-11T00:00:00Z"
    key_vault_secret_resource_group_name = "ploceusrg000002"       #(Required) Specifies the name of the resource group, where the key_vault resides in
    key_vault_secret_name                = "ploceuskvsecret000002" #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created


    key_vault_secret_tags = { #(Optional) A mapping of tags which should be assigned to the key vault secret. 

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

#KEY VAULT CERTIFICATE
key_vault_certificate_variables = {
  "key_vault_certificate_1" = {
    key_vault_certificate_name                          = "ploceuskeyvaultcertificate000001" #(Required) Specifies the name of the Key Vault Certificate. Changing this forces a new resource to be created.
    key_vault_certificate_key_vault_name                = "ploceuskv000001"                  #(Required) The name of the Key Vault where the Certificate should be created.
    key_vault_certificate_key_vault_resource_group_name = "ploceusrg000002"                  #(Required) The resource group name of the Key Vault where the Certificate should be created.
    key_vault_certificate_contents_secret_name          = null                               #(Required) The base64-encoded certificate contents stored as a secret in key vault.
    key_vault_certificate_password_secret_name          = null                               #(Optional) The password associated with the certificate. Use this if you are using an existing certificate stored in key vault, add password as a secret in key vault to fetch.
    key_vault_certificate_contents_secret_name          = null                               #(Optional) The base64-encoded certificate contents stored as a secret in key vault. Provide this when 'key_vault_certificate_fetch_certificate_enabled' is true
    key_vault_certificate_fetch_certificate_enabled     = false                              #(Required) If true, certificate from key vault will be used, otherwise a new certificate will be created and 'key_vault_certificate_certificate_policy' is required. Defaults to false 

    key_vault_certificate_certificate_policy = { #(Optional) A `certificate_policy` block as defined below. Required when 'key_vault_certificate_fetch_certificate_enabled' is true. Changing this will create a new version of the Key Vault Certificate.
      certificate_policy_issuer_parameters = {   #(Required) A `issuer_parameters` block as defined below.
        issuer_parameters_name = "Self"          #(Required) The name of the Certificate Issuer. Possible values include `Self` (for self-signed certificate), or `Unknown` (for a certificate issuing authority like `Let's Encrypt` and Azure direct supported ones). Changing this forces a new resource to be created.
      }
      certificate_policy_key_properties = { #(Required) A `key_properties` block as defined below.
        key_properties_curve      = null    #(Optional) Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-256K`, `P-384`, and `P-521`. This field will be required in a future release if `key_type` is `EC` or `EC-HSM`. Changing this forces a new resource to be created.
        key_properties_exportable = true    #(Required) Is this certificate exportable? Changing this forces a new resource to be created.
        key_properties_key_size   = 2048    #(Optional) The size of the key used in the certificate. Possible values include `2048`, `3072`, and `4096` for `RSA` keys, or `256`, `384`, and `521` for `EC` keys. This property is required when using RSA keys. Changing this forces a new resource to be created.
        key_properties_key_type   = "RSA"   #(Required) Specifies the type of key. Possible values are `EC`, `EC-HSM`, `RSA`, `RSA-HSM` and `oct`. Changing this forces a new resource to be created.
        key_properties_reuse_key  = true    #(Required) Is the key reusable? Changing this forces a new resource to be created.
      }
      certificate_policy_lifetime_action = { #(Optional) A `lifetime_action` block as defined below.
        lifetime_action_action = {           #(Required) A `action` block as defined below.
          action_type = "AutoRenew"          #(Required) The Type of action to be performed when the lifetime trigger is triggerec. Possible values include `AutoRenew` and `EmailContacts`. Changing this forces a new resource to be created.
        }
        lifetime_action_trigger = {          #(Required) A `trigger` block as defined below.
          trigger_days_before_expiry  = null #(Optional) The number of days before the Certificate expires that the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `lifetime_percentage`.
          trigger_lifetime_percentage = 90   #(Optional) The percentage at which during the Certificates Lifetime the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `days_before_expiry`.
        }
      }
      certificate_policy_secret_properties = {                  #(Required) A `secret_properties` block as defined below.
        secret_properties_content_type = "application/x-pkcs12" #(Required) The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM. Changing this forces a new resource to be created.
      }
      certificate_policy_x509_certificate_properties = {                       #(Optional) A `x509_certificate_properties` block as defined below. Required when `certificate` block is not specified.
        x509_certificate_properties_extended_key_usage = ["1.3.6.1.5.5.7.3.1"] #(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created.

        #(Required) A list of uses associated with this Key. Possible values include `cRLSign`, `dataEncipherment`, `decipherOnly`, `digitalSignature`, `encipherOnly`, `keyAgreement`, `keyCertSign`, `keyEncipherment` and `nonRepudiation` and are case-sensitive. Changing this forces a new resource to be created.
        x509_certificate_properties_key_usage          = ["cRLSign", "dataEncipherment", "decipherOnly", "digitalSignature", "encipherOnly", "keyAgreement", "keyCertSign", "keyEncipherment", "nonRepudiation"]
        x509_certificate_properties_subject            = "CN=ploceus.com"                              #(Required) The Certificate's Subject. Changing this forces a new resource to be created.
        x509_certificate_properties_validity_in_months = 12                                            #(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created.
        x509_certificate_properties_subject_alternative_names = {                                      #(Optional) A `subject_alternative_names` block as defined below. Changing this forces a new resource to be created.
          subject_alternative_names_dns_names = null                                                   #(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_emails    = ["XXXXXXXXXXX@ploceus.com", "XXXXXXXXXXX@ploceus.org"] #(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_upns      = null                                                   #(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created.
        }
      }
    }
    key_vault_certificate_tags = { #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#DISK ENCRYPTION SET
disk_encryption_set_variables = {
  "disk_encryption_set_01" = {
    disk_encryption_set_auto_key_rotation_enabled = false                             #(Optional) Boolean flag to specify whether Azure Disk Encryption Set automatically rotates encryption Key to latest version. Defaults to false
    disk_encryption_set_encryption_type           = "EncryptionAtRestWithCustomerKey" #(Optional) The type of key used to encrypt the data of the disk. Possible values are EncryptionAtRestWithCustomerKey, EncryptionAtRestWithPlatformAndCustomerKeys and ConfidentialVmEncryptedWithCustomerKey. Defaults to EncryptionAtRestWithCustomerKey.
    disk_encryption_set_federated_client_id       = null                              #(Optional) Multi-tenant application client id to access key vault in a different tenant.
    disk_encryption_set_identity = {
      disk_encryption_set_identities = [{                      #(Optional) Optional) A list of User Assigned Managed Identity IDs to be assigned to this Disk Encryption Set. Note: This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        user_identity_name                = "ploceusuai000001" #user assigned identity name Required if identity type ="userassigned" or "systemassigned,userassigned"
        user_identity_resource_group_name = "ploceusrg000001"  #resource group name of the user identity
      }]
      disk_encryption_set_identity_type = "UserAssigned" #(Required) The type of Managed Service Identity that is configured on this Disk Encryption Set. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
    }
    disk_encryption_set_key_vault_key_name            = "ploceuskvkey000001"            #(Required) Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret).
    disk_encryption_set_key_vault_name                = "ploceuskv000002"               #(Required) Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret).
    disk_encryption_set_location                      = "eastus"                        #(Required) Specifies the Azure Region where the Disk Encryption Set exists. Changing this forces a new resource to be created.
    disk_encryption_set_name                          = "ploceusdiskencrptionset000001" #(Required) The name of the Disk Encryption Set. Changing this forces a new resource to be created
    disk_encryption_set_resource_group_name           = "ploceusrg000002"
    disk_encryption_set_key_vault_resource_group_name = "ploceusrg000002" #(Required) key vault resource group name              #(Required) Specifies the name of the Resource Group where the Disk Encryption Set should exist. Changing this forces a new resource to be created.
    disk_encryption_set_tags = {                                          #(Optional) A mapping of tags which should be assigned to the disk encryption set.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#CAPACITY RESERVATION GROUP
capacity_reservation_group_variables = {
  "capacity_reservation_group_1" = {
    capacity_reservation_group_name                = "ploceuscrg000001" #(Required) Specifies the name of this Capacity Reservation Group. Changing this forces a new resource to be created.
    capacity_reservation_group_resource_group_name = "ploceusrg000001"  #(Required) Specifies the name of the resource group the Capacity Reservation Group is located in. Changing this forces a new resource to be created.
    capacity_reservation_group_location            = "eastus"           #(Required) The Azure location where the Capacity Reservation Group exists. Changing this forces a new resource to be created.
    capacity_reservation_group_zones               = []                 #(Optional) Specifies a list of Availability Zones for this Capacity Reservation Group. Changing this forces a new resource to be created.
    capacity_reservation_group_tags = {                                 #(Optional) A mapping of tags to assign to the resource.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SHARED IMAGE GALLERY
shared_image_gallery_variables = {
  shared_image_gallery_1 = {
    shared_image_gallery_name                = "ploceussimg000001" #(Required) Specifies the name of the Shared Image Gallery.
    shared_image_gallery_resource_group_name = "ploceusrg000001"   #(Required) The name of the resource group in which to create the Shared Image Gallery.
    shared_image_gallery_location            = "eastus"            #(Required) Specifies the supported Azure location where the resource exists.
    shared_image_gallery_description         = "ploceusdes00001"   #(Optional) A description for this Shared Image Gallery.
    shared_image_gallery_sharing             = null
    shared_image_gallery_tags = { #(Optional) A mapping of tags to assign to the Shared Image Gallery.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#GALLERY APPLICATION
gallery_application_variables = {
  gallery_application_1 = {
    gallery_application_name                                     = "ploceusgalleryapp000001"
    gallery_application_shared_image_gallery_name                = "ploceussimg000001"
    gallery_application_shared_image_gallery_resource_group_name = "ploceusrg000001"
    gallery_application_location                                 = "eastus"
    gallery_application_supported_os_type                        = "Windows"
    gallery_application_description                              = "ploceusdes00001"
    gallery_application_end_of_life_date                         = "2023-12-27T23:45:32Z"
    gallery_application_eula                                     = "ploceuseula"
    gallery_application_privacy_statement_uri                    = null
    gallery_application_release_note_uri                         = null
    gallery_application_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#STORAGE ACCOUNT
storage_account_variables = {
  "storage_account_01" = {
    storage_account_key_vault_name                                     = "ploceuskv000002"     #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = "ploceusrg000002"     #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = "ploceuskvkey000001"  #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = "ploceusuai000001"    #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = "ploceusrg000001"     #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = "SystemAssigned"      #(Required) The identity type of a user assigned identity for customer managed key.Only Possible value could be "UserAssigned" in order to use customer managed key. Other Possible values are "SystemAssigned", "SystemAssigned, UserAssigned"
    storage_account_name                                               = "ploceusstracc000001" #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = "ploceusrg000001"     #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = "eastus"              #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = "StorageV2"           #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = "Standard"            #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = "LRS"                 #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = true                  #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = "Hot"                 #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = null                  #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = true                  #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = "TLS1_2"              #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = true                  #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = true                  #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = true                  #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = false                 #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_is_hns_enabled                                     = false                 #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = false                 #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = false                 #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = "Service"             #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = "Service"             #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = false                 #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_allowed_copy_scope                                 = null                  #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_sftp_enabled                                       = false                 #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain                                      = null
    # storage_account_custom_domain = {
    #     custom_domain_name = "www.ploceus.com" #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    #     custom_domain_use_subdomain = false #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    # }

    storage_account_identity = null
    # storage_account_identity = {
    #   storage_account_identity_type = "UserAssigned" # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    #   # storage_account_user_assigned_identity_ids = null
    #   storage_account_user_assigned_identity_ids = [{ # This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
    #     identity_name                = "ploceusuai000002"
    #     identity_resource_group_name = "loceusrg000005"
    #   }]
    # }

    storage_account_blob_properties = {
      versioning_enabled            = true         #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = true         #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = 7            #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = "2020-06-12" #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = true         #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                                                 #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                                                 #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*", ]                                                               #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                                                    #(Required) The number of seconds the client should cache a preflight response.
      }
      restore_policy = {
        restore_policy_days = "4" #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
      }
      delete_retention_policy = {
        delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      }

      container_delete_retention_policy = {
        container_delete_retention_policy_days = "7" #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      }
    }

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

    storage_account_share_properties = {
      cors_enabled = true #(optional) Should cross origin resource sharing be enabled.
      cors_rule = {
        allowed_headers    = ["*"]                                   #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = ["GET", "HEAD", "MERGE", "POST", "PUT"] #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = ["*"]                                   #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = ["*"]                                   #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = 60                                      #(Required) The number of seconds the client should cache a preflight response.
      }

      retention_policy = {
        retention_policy_days = 7 #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      }

      smb = {
        smb_versions                        = ["SMB2.1"]      #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = ["NTLMv2"]      #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = ["RC4-HMAC"]    #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = ["AES-128-CCM"] #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = false           #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      }
    }

    storage_account_network_rules = null /* {
      default_action = "Deny"                 #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = ["Logging", "Metrics"] #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = ["8.29.228.191"]        #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = [{
        storage_account_network_rules_virtual_network_name = "ploceusvnet000001"                   #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = "ploceussubnet000001"                 #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = "xxxxxxx-xxxxxxx-xxxxxxxxx-xxxxxxxxx" #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = "ploceusrg000001"                     #(Required) Resource group where Vnet is created.
        }]

      private_link_access = null /*{
        "private_link_access_01" = {
          endpoint_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/XXXXXXXXXXXXXXXXXXXX/providers/Microsoft.Sql/servers/XXXXXXXXXXXXXXXXXXXX"
          endpoint_tenant_id   = "xxxxxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx"
        }
      }
    } */

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
      publish_internet_endpoints  = false             #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = false             #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = "InternetRouting" #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    }

    storage_account_immutability_policy = null /* {
      allow_protected_append_writes = false      #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = "Disabled" #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = 7          #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    } */

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

#STORAGE CONTAINER
storage_container_variables = {
  "storage_container" = {
    storage_container_name                  = "ploceusstrcon000001" #Required The name of the Container which should be created within the Storage Account.
    storage_container_storage_account_name  = "ploceusstracc000001" #Required The name of the Storage Account where the Container should be created.
    storage_container_container_access_type = "container"           #Optional The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private.
    storage_container_metadata              = null                  #Optional A mapping of MetaData for this Container. All metadata keys should be lowercase.
  }
}

#STORAGE BLOB
storage_blob_variables = {
  storage_blob_1 = {
    storage_blob_name                   = "ploceusblob000001"   #(Required) The name of the storage blob. Must be unique within the storage container the blob is located.
    storage_blob_storage_account_name   = "ploceusstracc000001" #(Required) Specifies the storage account in which to create the storage container. Changing this forces a new resource to be created.
    storage_blob_storage_container_name = "ploceusstrcon000001" #(Required) The name of the storage container in which this blob should be created.
    storage_blob_type                   = "Block"               #(Required) The type of the storage blob to be created. Possible values are Append, Block or Page. Changing this forces a new resource to be created.
    storage_blob_size                   = null                  #(Optional) Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512. Defaults to 0.
    storage_blob_content_type           = null                  #(Optional) The content type of the storage blob. Cannot be defined if source_uri is defined. Defaults to application/octet-stream.
    storage_blob_source                 = "./main.tf"           #(Optional) An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source_content or source_uri is specified.
    storage_blob_source_uri             = null                  #(Optional) The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created. Changing this forces a new resource to be created. This field cannot be specified for Append blobs and cannot be specified if source or source_content is specified.
    storage_blob_access_tier            = "Cool"                #(Optional) The access tier of the storage blob. Possible values are Archive, Cool and Hot.
    storage_blob_cache_control          = null                  #(Optional) Controls the cache control header content of the response when blob is requested .
    storage_blob_content_md5            = null                  #(Optional) The MD5 sum of the blob contents. Cannot be defined if source_uri is defined, or if blob type is Append or Page. Changing this forces a new resource to be created.
    storage_blob_source_content         = null                  #(Optional) The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source_uri is specified.
    storage_blob_parallelism            = 8                     #(Optional) The number of workers per CPU core to run for concurrent uploads. Defaults to 8.
    storage_blob_metadata = {                                   #(Optional) A map of custom blob metadata.
      name = "Inputfile"
    }
  }
}

#GALLERY APPLICATION VERSION
gallery_application_version_variables = {
  "gallery_application_version_1" = {
    gallery_application_version_name                                     = "1.2.3"                   #(Required) The version name of the Gallery Application Version, such as 1.0.0. Changing this forces a new resource to be created.
    gallery_application_version_shared_image_gallery_name                = "ploceussimg000001"       #(Required) The name of the Shared Image Gallery.
    gallery_application_version_shared_image_gallery_resource_group_name = "ploceusrg000001"         #(Required) The name of the Resource Group in which the Shared Image Gallery exists.
    gallery_application_version_gallery_application_name                 = "ploceusgalleryapp000001" #(Required) The name of the Gallery Application.
    gallery_application_version_storage_account_name                     = "ploceusstracc000001"     #(Required) The name of the Storage Account where the Container exists.
    gallery_application_version_storage_container_name                   = "ploceusstrcon000001"     #(Required) The name of the Storage Container where the Blob exists.
    gallery_application_version_storage_blob_name                        = "ploceusblob000001"       #(Required) The name of the Storage Blob.
    gallery_application_version_location                                 = "eastus"                  #(Required) The Azure Region where the Gallery Application Version exists. Changing this forces a new resource to be created.
    gallery_application_version_enable_health_check                      = null                      #(Optional) Should the Gallery Application reports health. Defaults to false.
    gallery_application_version_end_of_life_date                         = null                      #(Optional) The end of life date in RFC3339 format of the Gallery Application Version.
    gallery_application_version_exclude_from_latest                      = null                      #(Optional) Should the Gallery Application Version be excluded from the latest filter? If set to true this Gallery Application Version won't be returned for the latest version. Defaults to false.

    gallery_application_version_manage_action = { #(Required) A manage_action block as defined below.
      manage_action_install = "[install command]" #(Required) The command to install the Gallery Application. Changing this forces a new resource to be created.
      manage_action_remove  = "[remove command]"  #(Required) The command to remove the Gallery Application. Changing this forces a new resource to be created.
      manage_action_update  = null                #(Optional) The command to update the Gallery Application. Changing this forces a new resource to be created.
    }

    gallery_application_version_source = {     #(Required) A source block as defined below.
      source_default_configuration_link = null # (Optional)The Storage Blob URI of the default configuration. Changing this forces a new resource to be created.
    }

    gallery_application_version_target_region = {     #(Required) One or more target_region blocks as defined below.
      target_region_name                   = "eastus" #(Required) The Azure Region in which the Gallery Application Version exists.
      target_region_regional_replica_count = 1        #(Required) The number of replicas of the Gallery Application Version to be created per region. Possible values are between 1 and 10.
      target_region_storage_account_type   = null     #(Optional) The storage account type for the Gallery Application Version. Possible values are Standard_LRS, Premium_LRS and Standard_ZRS. Defaults to Standard_LRS.
    }

    gallery_application_version_tags = { #(Optional) A mapping of tags to assign to the Gallery Application Version.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#NETWORK INTERFACE
network_interface_variables = {
  "network_interface_1" = {
    network_interface_name                          = "ploceusnic000001" #The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = "eastus"           #The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = "ploceusrg000001"  #The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = null               # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = null               # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = []                 #if provided, it will override the DNS server value defined in vnet module
    network_interface_edge_zone                     = null               #Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created
    network_interface_enable_ip_forwarding          = false              #Enable only if IP Forwarding is required
    network_interface_enable_accelerated_networking = false              #Enable only if accelerated networking is required
    network_interface_internal_dns_label            = null               #The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = {
      "ip_configuration_1" = {
        ip_configuration_name                          = "ploceusnicipconfig000001" #A name used for this IP Configuration. Changing this forces a new resource to be created
        ip_configuration_private_ip_address_allocation = "Dynamic"                  #Possible values are Dynamic and Static
        #ip_configuration_private_ip_address            = "10.0.3.11"                #When private_ip_address_allocation is set to Static, The Static IP Address which should be used
        ip_configuration_private_ip_address         = null
        ip_configuration_private_ip_address_version = "IPv4" #The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
        ip_configuration_subnet = ({
          subnet_virtual_network_name                = "ploceusvnet000001"   #When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID
          subnet_name                                = "ploceussubnet000001" #When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID
          subnet_virtual_network_resource_group_name = "ploceusrg000001"     #When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID
        })
        ip_configuration_public_ip = ({                           #Reference to a Public IP Address to associate with this NIC
          public_ip_name                = "ploceuspublicip000001" #Reference to a Public IP Address Name to associate with this NIC
          public_ip_resource_group_name = "ploceusrg000001"       #Reference to a Public IP Address Name Resource Group Name to associate with this NIC
        })
        ip_configuration_primary       = true #Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.Must be true for the first ip_configuration when multiple are specified
        ip_configuration_load_balancer = null /*({
          load_balancer_name                = "ploceuslb00001"  #Only works with Gateway SKU Load Balancer
          load_balancer_resource_group_name = "ploceusrg000001" #The Load Balancer Resource Group name is required to fetch the Load Balancer ID
        })*/
      }
    }
    network_interface_tags = { #(Optional) A mapping of tags to assign to the resource.
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
  }
}

#NETWORK SECURITY GROUP
network_security_group_variables = {
  "network_security_group_1" = {
    network_security_group_name                = "ploceusnsg000001" # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = "eastus"           # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = {
      "nsg_rule_01" = {
        security_rule_name                                           = "ploceusnsgrule000002" # (Required) The name of the security rule
        security_rule_application_security_group_resource_group_name = null                   # (Optional) The resource group name of the application security group
        security_rule_priority                                       = 100                    # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
        security_rule_direction                                      = "Inbound"              # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
        security_rule_access                                         = "Allow"                # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
        security_rule_protocol                                       = "Tcp"                  # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
        security_rule_source_port_range                              = "*"                    # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified
        security_rule_source_port_ranges                             = null                   # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
        security_rule_destination_port_range                         = "*"                    # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
        security_rule_destination_port_ranges                        = null                   # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified
        security_rule_source_address_prefix                          = "*"                    # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified.
        security_rule_source_address_prefixes                        = null                   # (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
        security_rule_destination_address_prefix                     = "*"                    # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
        security_rule_destination_address_prefixes                   = null                   # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
        security_rule_description                                    = "InboundAllow100"      # (Optional) A description for this rule. Restricted to 140 characters
        security_rule_source_application_security_group_names        = null                   # (Optional) A List of source Application Security Group names
        security_rule_destination_application_security_group_names   = null                   # (Optional) A List of destination Application Security Group names
      }
    }
    network_security_group_tags = { # (Optional) A mapping of tags which should be assigned to the Network Security Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#NETWORK INTERFACE SECURITY GROUP ASSOCIATION
network_interface_security_group_association_variables = {
  "network_interface_security_group_association_variables_1" = {

    network_interface_security_group_association_network_interface_name                     = "ploceusnic000001" # (Required) The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_security_group_association_network_interface_resource_group_name      = "ploceusrg000001"  # (Required) The ID of the Network Interface. Changing this forces a new resource to be created.
    network_interface_security_group_association_network_security_group_name                = "ploceusnsg000001" # (Required) The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created.
    network_interface_security_group_association_network_security_group_resource_group_name = "ploceusrg000001"  # (Required) The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created.
  }
}

#SUBNET NETWORK SECURITY GROUP ASSOCIATION 
subnet_network_security_group_association_variables = {
  "network_security_group_association_1" = {
    subnet_network_security_group_association_subnet_name                                = "ploceussubnet000001" #(Required)Subnet name for network security group association
    subnet_network_security_group_association_virtual_network_name                       = "ploceusvnet000001"   #(Required)Virtual network name for subnet network security group association 
    subnet_network_security_group_association_subnet_resource_group_name                 = "ploceusrg000001"     #(Required)Name of subnet for creating nsg group association
    subnet_network_security_group_association_network_security_group_name                = "ploceusnsg000001"    #(Required)Name of Network Security group for subnet association
    subnet_network_security_group_association_network_security_group_resource_group_name = "ploceusrg000001"     #(Required)Resource group name for network security group association
  }
}

#LINUX VM
linux_virtual_machine_variables = {
  "linux_virtual_machine_1" = {
    linux_virtual_machine_admin_username = "ploceususer"        #(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_location       = "eastus"             #(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
    linux_virtual_machine_license_type   = null                 #(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS.
    linux_virtual_machine_name           = "ploceuslinux000001" #(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_os_disk = {                           #(Required) A os_disk block as defined below.
      os_disk_caching              = null                       #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
      os_disk_storage_account_type = "Standard_LRS"             #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.
      os_disk_diff_disk_settings = {                            #(Optional) A diff_disk_settings block as defined above. Changing this forces a new resource to be created.
        diff_disk_settings_option    = "Local"                  # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
        diff_disk_settings_placement = null                     #(Optional) Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.
      }
      os_disk_disk_size_gb              = 70                    #(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
      os_disk_name                      = "ploceusosdisk000001" #(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
      os_disk_security_encryption_type  = null                  #(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are VMGuestStateOnly and DiskWithVMGuestState. Changing this forces a new resource to be created.
      os_disk_write_accelerator_enabled = false                 #(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to false.
    }
    linux_virtual_machine_resource_group_name = "ploceusrg000001" #(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
    linux_virtual_machine_size                = "Standard_B2ms"   #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2.
    linux_virtual_machine_additional_capabilities = {             #(Optional) A additional_capabilities block as defined below.
      additional_capabilities_ultra_ssd_enabled = false           #(Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
    }
    linux_virtual_machine_allow_extension_operations            = false                 #(Optional) Should Extension Operations be allowed on this Virtual Machine?
    linux_virtual_machine_boot_diagnostics_storage_account_name = "ploceusstracc000001" # Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_computer_name                         = "ploceuslinux000001"  #(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created.
    linux_virtual_machine_custom_data                           = null                  #(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_disable_password_authentication       = false                 #(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_edge_zone                             = null                  #(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_encryption_at_host_enabled            = false                 #(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?
    linux_virtual_machine_eviction_policy                       = null                  #(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created.
    linux_virtual_machine_extensions_time_budget                = "PT1H30M"             #(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
    linux_virtual_machine_gallery_application                   = null                  #(Optional) A gallery_application block as defined below.
    /* Sample Code {
      #gallery_application_configuration_blob_uri = string                               #(Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
      gallery_application_order                  = 1                               #(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647.
      gallery_application_tag                    = null                               #(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
    }  */
    linux_virtual_machine_identity = {               #(Optional)
      identity_type = "SystemAssigned, UserAssigned" #(Required) The type of Managed Service Identity that is configured on this Disk Encryption Set. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      linux_virtual_machine_user_assigned_identities = [{
        user_assigned_identities_name                = "ploceusuai000001" #(Required)Name of the user assigned identity
        user_assigned_identities_resource_group_name = "ploceusrg000001"  #(Required)Resource group name of the user assigned identity
      }]
    }
    linux_virtual_machine_patch_assessment_mode = null           #(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault.
    linux_virtual_machine_patch_mode            = "ImageDefault" # (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see the product documentation.
    linux_virtual_machine_max_bid_price         = "-1"           #(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
    linux_virtual_machine_plan                  = null           #(Optional) A plan block as defined below. Changing this forces a new resource to be created.
    linux_virtual_machine_platform_fault_domain = null           #(Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_priority              = "Regular"      #(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
    linux_virtual_machine_provision_vm_agent    = false          #(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_secure_boot_enabled   = false          #(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_source_image_reference = {             #Optional) A source_image_reference block as defined below. Changing this forces a new resource to be created.
      source_image_reference_publisher = "Canonical"             #(Optional) Specifies the publisher of the image used to create the virtual machines.
      source_image_reference_offer     = "UbuntuServer"          #(Optional) Specifies the offer of the image used to create the virtual machines.
      source_image_reference_sku       = "18.04-LTS"             #(Optional) Specifies the SKU of the image used to create the virtual machines.
      source_image_reference_version   = "latest"                #(Optional) Specifies the version of the image used to create the virtual machines.
    }
    linux_virtual_machine_termination_notification = [{ #(Optional) A termination_notification block as defined below.
      termination_notification_enabled = true           #(Required) Should the termination notification be enabled on this Virtual Machine? Defaults to false.
      termination_notification_timeout = "PT10M"        #(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format.
    }]
    linux_virtual_machine_user_data    = null  #(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
    linux_virtual_machine_vtpm_enabled = false #(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_zone         = null  #(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }

    linux_virtual_machine_use_existing_vm_username                   = false             #(Required)should be set true if existing user name is used
    linux_virtual_machine_generate_new_admin_password                = true              #(Required)admin_password should be generated if disable_password_authentication is false
    linux_virtual_machine_generate_new_ssh_key                       = true              #(Required)Should be true/false if linux_virtual_machine_disable_password_authentication is true
    linux_virtual_machine_admin_login_key_vault_name                 = "ploceuskv000001" #"existingkeyvaultscenario"
    linux_virtual_machine_tls_private_key_algorithm                  = "RSA"             #Provide Algorithm used for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_tls_private_key_rsa_bits                   = 2048              #Provide number if bits for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_admin_ssh_key_vault_secret_expiration_date = "2023-12-11T00:00:00Z"
    linux_virtual_machine_admin_ssh_key_vault_secret_content_type    = "credential"
    linux_virtual_machine_admin_ssh_key_vault_secret_name            = "ploceuskvsecret000004" #Key vault secret name to store the ssh key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_is_disk_encryption_set_required            = false                   #(Required)Boolean value if disk encryption set is required or not
    linux_virtual_machine_is_storage_blob_required                   = true                    #(Required)Boolean value if blob storage is required
    linux_virtual_machine_storage_blob_name                          = "ploceusblob000001"     #Provide blob storage name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_storage_account_name                       = "ploceusstracc000001"   #Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_storage_container_name                     = "ploceusstrcon000001"   #Provide storage container name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_is_gallery_application_id_required         = false                   #(Required)Boolean value if gallery application id is required
    linux_virtual_machine_gallery_application_version_name           = null                    #Provide version name if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_shared_image_gallery_name                  = null                    #Name of the shared image gallery. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_gallery_application_name                   = null                    #Name of gallery application. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_is_capacity_reservation_group_id_required  = false                   #(Required)Boolean value if capacity reservation group id is required
    linux_virtual_machine_capacity_reservation_group_name            = null                    #Provide capacity reservation group name if linux_virtual_machine_is_capacity_reservation_group_id_required is set to true
    linux_virtual_machine_is_key_vault_certificate_url_required      = false                   #(Required)Boolean value if key vault certificate url is required
    linux_virtual_machine_key_vault_certificate_name                 = null                    #Provide key vault certificate name if linux_virtual_machine_is_key_vault_certificate_url_required is set to true
    linux_virtual_machine_is_vmss_id_required                        = false                   #(Required)Boolean value if VMSS id is required
    linux_virtual_machine_network_interface = {                                                #(Required) Map of object for network interface
      "nic1" = {
        network_interface_name                = "ploceusnic000001" #(Required)Name of the network interface
        network_interface_resource_group_name = "ploceusrg000001"  #(Required)Resource group name of network interface
      }
    }
    linux_virtual_machine_is_secret_required                                     = false                           #(Required)Boolean value if secret is required or not
    linux_virtual_machine_disk_encryption_set_name                               = "ploceusdiskencrptionset000001" #Name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_is_boot_diagnostics_required                           = true                            #(Required)Boolean value if boot diagnostics required
    linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled = false                           #(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false.Can only be set to true when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_availability_set_id_required                        = false                           #(Required)Boolean value if availability set id required
    linux_virtual_machine_is_proximity_placement_group_id_required               = false                           #(Required)Boolean value if proximity placement group id required
    linux_virtual_machine_reboot_setting                                         = null                            # (Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_dedicated_host_group_id_required                    = false                           #(Required)Boolean value if dedicated host group id required
    linux_virtual_machine_is_dedicated_host_id_required                          = false                           #(Required)Boolean value if dedicated host id required
    linux_virtual_machine_deploy_vm_using_source_image_reference                 = true                            #(Required)Boolean value if VM should be deployed using source image reference
    linux_virtual_machine_availability_set_name                                  = null                            # Provide availability set name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_availability_set_resource_group_name                   = "ploceusrg000001"               # Provide availability set resource group name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_dedicated_host_group_name                              = null                            # Provide host group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_group_resource_group_name               = null                            # Provide host group resource group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_name                                    = null                            # Provide host name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_dedicated_host_resource_group_name                     = null                            # Provide host resource group name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_proximity_placement_group_name                         = "ploceusproximitygroup000001"   # Provide proximity palcement group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_proximity_placement_group_resource_group_name          = "ploceusrg000001"               # Provide proximity palcement group resource group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_generated_admin_password_secret_name                   = "ploceuskvsecret000003"         #Provide Key vault secret name to store random password if linux_virtual_machine_generate_new_admin_password is true
    linux_virtual_machine_generated_admin_password_secret_expiration_date        = "2023-12-11T00:00:00Z"
    linux_virtual_machine_generated_admin_password_secret_content_type           = "password"
    linux_virtual_machine_existing_admin_password_secret_name                    = null                    #Provide Key vault secret name where the existing password exists if linux_virtual_machine_generate_new_admin_password is false
    linux_virtual_machine_virtual_machine_scale_set_name                         = null                    #Provide Vm scale set name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_virtual_machine_scale_set_resource_group_name          = null                    #Provide VM scale set resource group name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_source_image_type                                      = "PlatformImage"         #Provide image type if linux_virtual_machine_deploy_vm_using_source_image_reference is set to false. If you are using existing vm image make image type as "VMImage" if you are using share image give as "SharedImage"
    linux_virtual_machine_shared_image_name                                      = null                    #Provide image name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_shared_image_resource_group_name                       = null                    #Provide image resource group name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_existing_image_name                                    = null                    #Provide image name if linux_virtual_machine_source_image_type is "VMImage"
    linux_virtual_machine_existing_image_resource_group_name                     = null                    #Provide existing image resource group name if image type is "VMImage"
    linux_virtual_machine_admin_key_vault_resource_group_name                    = "ploceusrg000002"       #Provide key vault resource group name to store credentials
    linux_virtual_machine_storage_account_resource_group_name                    = "ploceusrg000001"       #Provide value if linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_disk_encryption_set_resource_group_name                = "ploceusrg000002"       #Resource group name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_existing_admin_username_secret_name                    = "ploceuskvsecret000002" #Provide Key vault secret name to store admin username. Provide value if linux_virtual_machine_use_existing_vm_username is set to true.
  }
}
linux_vm_subscription_id  = "xxxx-xxxx-xxxx-xxxx"
linux_vm_tenant_id        = "xxxx-xxxx-xxxx-xxxx"
key_vault_subscription_id = "xxxx-xxxx-xxxx-xxxx"
key_vault_tenant_id       = "xxxx-xxxx-xxxx-xxxx"
gallery_subscription_id   = "xxxx-xxxx-xxxx-xxxx"
gallery_tenant_id         = "xxxx-xxxx-xxxx-xxxx"
