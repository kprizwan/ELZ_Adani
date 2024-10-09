#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#RESOURCE GROUP KEY VAULT VARIABLES
variable "key_vault_resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default     = {}
}

#VIRTUAL NETWORK VARIABLES
variable "virtual_network_variables" {
  type = map(object({
    virtual_network_name                    = string       #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string       #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string       #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string) #(Required) the address space that is used the virtual network. You can supply more than one address space.
    virtual_network_dns_servers             = list(string) #(Optional) list of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = number       #(Optional) the flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = string       #(Optional) the BGP community attribute in format <as-number>:<community-value>.
    virtual_network_ddos_protection_plan = object({        #(Optional) block for ddos protection
      virtual_network_ddos_protection_enable    = bool     #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = string   #(Required) for the ID of DDoS Protection Plan.
    })
    virtual_network_edge_zone = string                #(Optional) specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_encryption = list(object({        #(Optional) A encryption block as defined below.
      virtual_network_encryption_enforcement = string #(Required) Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted.
    }))
    virtual_network_subnet = list(object({                                       #(Optional) for the subnet block config. Set to null if not required
      virtual_network_subnet_name                                       = string #(Required) the subnet name to attach to vnet
      virtual_network_subnet_address_prefix                             = string #(Required) the address prefix to use for the subnet.
      virtual_network_subnet_network_security_group_name                = string #(Optional) the Network Security Group Name to associate with the subnet.
      virtual_network_subnet_network_security_group_resource_group_name = string #(Optional) the Network Security Group Resource Group to associate with the subnet.
    }))
    virtual_network_tags = map(string) #(Optional)a mapping of tags to assign to the resource.
  }))
  default     = {}
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
}

#SUBNET VARIABLES
variable "subnet_variables" {
  type = map(object({
    subnet_name                                          = string       # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = string       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_virtual_network_name                          = string       #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = list(string) #(Required) The address prefixes to use for the subnet.
    subnet_private_link_service_network_policies_enabled = bool         # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = bool         # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoints                             = list(string) #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    subnet_service_endpoint_policy_ids                   = list(string) #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    delegation = list(object({
      delegation_name            = string       #(Required) A name for this delegation.
      service_delegation_name    = string       # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = list(string) #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }))
  }))
  default     = {}
  description = "Map of Subnet Variables"
}

#PUBLIC IP VARIABLES
variable "public_ip_variables" {
  type = map(object({
    public_ip_name                                     = string       # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = string       # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = string       # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = string       # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = string       # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = string       # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = string       # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_zones                                    = list(string) # (Optional) A collection containing the availability zone to allocate the Public IP in.
    public_ip_edge_zone                                = string       # (Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. 
    public_ip_domain_name_label                        = string       # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_idle_timeout_in_minutes                  = string       # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_reverse_fqdn                             = string       # (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
    public_ip_prefix_id                                = string       # (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_ip_tags                                  = map(string)  # (Optional) A mapping of IP tags to assign to the public IP.
    public_ip_is_ddos_protection_plan_enabled          = bool         # (Required) True if ddos_protection_plan enabled, else false
    public_ip_ddos_protection_plan_name                = string       # (Optional) The Name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_plan_resource_group_name = string       # (Optional) The Resource group name of DDoS protection plan associated with the public IP.
    public_ip_ddos_protection_mode                     = string       # (Optional) The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited.
    public_ip_tags                                     = map(string)  # (Optional) Public IP tags
  }))
  description = "Map of object of Pubic IP variables"
  default     = {}
}

#USER ASSIGNED IDENTITY VARIABLES
variable "user_assigned_identity_variables" {
  type = map(object({
    user_assigned_identity_name                = string      #(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_location            = string      # (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_resource_group_name = string      #Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    user_assigned_identity_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the User Assigned Identity
  }))
  description = "Map of User Assigned Identities"
  default     = {}
}

#LB VARIABLES
variable "lb_variables" {
  type = map(object({
    lb_name                = string #(Required) Specifies the name of the Load Balancer.
    lb_resource_group_name = string # (Required) The name of the Resource Group in which to create the Load Balancer.
    lb_location            = string ## (Required) Specifies the supported Azure Region where the Load Balancer should be created.
    lb_edge_zone           = string #(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created.
    lb_frontend_ip_configuration = map(object({
      frontend_ip_configuration_name  = string #(Required) Specifies the name of the frontend IP configuration.
      frontend_ip_configuration_zones = list(string)
      frontend_ip_configuration_subnet = object({
        subnet_name                    = string # Subnet name
        subnet_virtual_network_name    = string # virtual network name where subnet resides.
        virtual_network_resource_group = string # Resource group name where the virtual network resides.
      })
      frontend_ip_configuration_gateway_lb_frontend_ip_configuration_id = object({ #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
        gateway_lb_name                = string                                    # gateway load balancer name
        gateway_lb_resource_group_name = string                                    # gateway load balancer resource group name
      })
      frontend_ip_configuration_private_ip_address            = string # (Optional) Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned.
      frontend_ip_configuration_private_ip_address_allocation = string #(Optional) The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static.
      frontend_ip_configuration_private_ip_address_version    = string #The version of IP that the Private IP Address is. Possible values are IPv4 or IPv6.
      frontend_ip_configuration_public_ip_address_id = object({
        public_ip_name                = string # public ip  name
        public_ip_resource_group_name = string # public ip resource group name
      })
      frontend_ip_configuration_public_ip_prefix_id = object({
        public_ip_prefix_name                = string # public ip prefix name
        public_ip_prefix_resource_group_name = string # public ip prefix resource group name            
      })
    }))
    lb_sku      = string      #(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic.
    lb_sku_tier = string      #(Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created.
    lb_tags     = map(string) # (Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of object of LB variables"
  default     = {}
}

#KEY VAULT VARIABLES FOR DISK ENCRYPTION
variable "key_vault_variables_disk_encryption" {
  type = map(object({
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_resource_group_name                   = string       #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_location                              = string       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_enabled_for_disk_encryption           = bool         #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = bool         #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = bool         # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = bool         #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = string       #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = bool         # (Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = string       #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = string       #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = string       #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = bool         #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update
    key_vault_tags                                  = map(string)  #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_network_acls_enabled                  = bool         #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass                   = string       #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action           = string       # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules                 = list(string) # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = list(object({
      key_vault_network_acls_virtual_networks_virtual_network_name    = string #(Required) Vitural Network name to be associated.
      key_vault_network_acls_virtual_networks_subnet_name             = string #(Required) Subnet Name to be associated.
      key_vault_network_acls_virtual_networks_subscription_id         = string #(Required) Subscription Id where Vnet is created.
      key_vault_network_acls_virtual_networks_virtual_network_rg_name = string #(Required) Resource group where Vnet is created.
    }))
    key_vault_contact_information_enabled = bool   #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = string #(Required) E-mail address of the contact.
    key_vault_contact_name                = string #(Optional) Name of the contact.
    key_vault_contact_phone               = string #(Optional) Phone number of the contact.
  }))
  description = "Map of Variables for Key Vault details"
  default     = {}
}

#KEY VAULT VARIABLES FOR SSH KEYS
variable "key_vault_variables_ssh_keys" {
  type = map(object({
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_resource_group_name                   = string       #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_location                              = string       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_enabled_for_disk_encryption           = bool         #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = bool         #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = bool         # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = bool         #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = string       #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = bool         # (Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = string       #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_access_container_agent_name           = string       #(Optional) Self hosted conatiner agent name.
    key_vault_access_policy_application_id          = string       #(Optional) The object ID of an Application in Azure Active Directory.
    key_vault_public_network_access_enabled         = bool         #(Optional) key_vault_public_network_access_enabled
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update
    key_vault_tags                                  = map(string)  #(Optional) A mapping of tags which should be assigned to the key vault.
    key_vault_network_acls_enabled                  = bool         #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass                   = string       #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action           = string       # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules                 = list(string) # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = list(object({
      key_vault_network_acls_virtual_networks_virtual_network_name    = string #(Required) Vitural Network name to be associated.
      key_vault_network_acls_virtual_networks_subnet_name             = string #(Required) Subnet Name to be associated.
      key_vault_network_acls_virtual_networks_subscription_id         = string #(Required) Subscription Id where Vnet is created.
      key_vault_network_acls_virtual_networks_virtual_network_rg_name = string #(Required) Resource group where Vnet is created.
    }))
    key_vault_contact_information_enabled = bool   #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = string #(Required) E-mail address of the contact.
    key_vault_contact_name                = string #(Optional) Name of the contact.
    key_vault_contact_phone               = string #(Optional) Phone number of the contact.
  }))
  description = "Map of Variables for Key Vault details"
  default = {
  }
}

#KEY VAULT ACCESS POLICY VARIABLES
variable "key_vault_access_policy_variables" {
  type = map(object({
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = string       #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = string       #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name 
    key_vault_access_resource_type                  = string       #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }))
  description = "Map of variables for key vault access policies"
  default     = {}
}

#KEY VAULT ACCESS POLICY VARIABLES DISK
variable "key_vault_access_policy_disk_variables" {
  type = map(object({
    key_vault_access_policy_key_permissions         = list(string) #(Optional) List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.
    key_vault_access_policy_secret_permissions      = list(string) #(Optional) List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.
    key_vault_access_policy_storage_permissions     = list(string) #(Optional) List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.
    key_vault_access_policy_certificate_permissions = list(string) #(Optional) List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault resource.
    key_vault_resource_group_name                   = string       #(Required) Specifies the resource group name where the key vault resides in.
    key_vault_access_resource_name                  = string       #(Required) Specifies the resource name that needs the access policy to the key vault. Possible values are username, group name, service principal name and application name 
    key_vault_access_resource_type                  = string       #(Required) Specifies the type of resource that needs the access policy to the key vault. Possible values are User, SPN, Group, Application
  }))
  description = "Map of variables for key vault access policies"
  default     = {}
}

#KEY VAULT KEY VARIABLES
variable "key_vault_key_variables" {
  type = map(object({
    key_vault_name                = string          #(Required) The name of the Key Vault where the Key should be created.
    key_vault_resource_group_name = string          #(Required) The resource group name of the Key Vault where the Key should be created.
    key_vault_key_name            = string          #(Required) Specifies the name of the Key Vault Key.
    key_vault_key_key_type        = string          #(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM.
    key_vault_key_key_size        = number          #(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM.
    key_vault_key_curve           = string          #(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521. This field will be required in a future release if key_type is EC or EC-HSM. The API will default to P-256 if nothing is specified.
    key_vault_key_key_opts        = list(string)    #(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive.
    key_vault_key_not_before_date = string          #(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_expiration_date = string          #(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_key_rotation_policy = object({        #(Optional) A rotation_policy block as defined below.
      rotation_policy_expire_after         = string #(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration.
      rotation_policy_notify_before_expiry = string #(Optional) Notify at a given duration before expiry as an ISO 8601 duration. Default is P30D.
      rotation_policy_automatic = object({          #(Optional) An automatic block as defined below.
        automatic_time_after_creation = string      #(Optional) Rotate automatically at a duration after create as an ISO 8601 duration.
        automatic_time_before_expiry  = string      #(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration.
      })
    })
    key_vault_key_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default     = {}
  description = "Map of object of key vault key variables"
}

#KEY VAULT SECRET VARIABLES
variable "key_vault_secret_variables" {
  type = map(object({
    key_vault_name                       = string      #(Required) Specifies the name of the Key Vault.
    key_vault_secret_resource_group_name = string      #(Required) Specifies the name of the resource group, where the key_vault resides in.
    key_vault_secret_name                = string      #(Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created
    key_vault_secret_value               = string      #(Required) Specifies the value of the Key Vault Secret
    key_vault_secret_content_type        = string      #(Optional) Specifies the content type for the Key Vault Secret
    key_vault_secret_not_before_date     = string      #(Optional) Specifies that the key is not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')
    key_vault_secret_expiration_date     = string      #(Optional) Specifies the expiration UTC datetime (Y-m-d'T'H:M:S'Z').
    key_vault_secret_tags                = map(string) #(Optional) A mapping of tags which should be assigned to the key vault secret.
    key_vault_secret_min_upper           = number      #(Optional)(Number) Minimum number of uppercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_lower           = number      #(Optional)(Number) Minimum number of lowercase alphabet characters in the result. Default value is 0
    key_vault_secret_min_numeric         = number      #(Optional)(Number) Minimum number of numeric characters in the result. Default value is 0
    key_vault_secret_min_special         = number      #(Optional)(Number) Minimum number of special characters in the result. Default value is 0
    key_vault_secret_length              = number      #(Optional)(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)
  }))
  description = "Map of variables for key vault secrets"
  default     = {}
}

#KEY VAULT CERTIFICATE VARIABLES
variable "key_vault_certificate_variables" {
  type = map(object({
    key_vault_certificate_name                          = string #(Required) Specifies the name of the Key Vault Certificate. Changing this forces a new resource to be created.
    key_vault_certificate_key_vault_name                = string #(Required) The name of the Key Vault where the Certificate should be created.
    key_vault_certificate_key_vault_resource_group_name = string #(Required) The resource group name of the Key Vault where the Certificate should be created.
    key_vault_certificate_contents_secret_name          = string #(Required) The base64-encoded certificate contents stored as a secret in key vault.
    key_vault_certificate_password_secret_name          = string #(Optional) The password associated with the certificate. Use this if you are using an existing certificate stored in key vault, add password as a secret in key vault to fetch.
    key_vault_certificate_contents_secret_name          = string #(Required) The base64-encoded certificate contents stored as a secret in key vault.
    key_vault_certificate_fetch_certificate_enabled     = bool   #(Required) If true, certificate from key vault will be used, otherwise a new certificate will be created and 'key_vault_certificate_certificate_policy' is required. Defaults to false 

    key_vault_certificate_certificate_policy = object({ #(Optional) A `certificate_policy` block as defined below. Required when 'key_vault_certificate_fetch_certificate_enabled' is true. Changing this will create a new version of the Key Vault Certificate.
      certificate_policy_issuer_parameters = object({   #(Required) A `issuer_parameters` block as defined below.
        issuer_parameters_name = string                 #(Required) The name of the Certificate Issuer. Possible values include `Self` (for self-signed certificate), or `Unknown` (for a certificate issuing authority like `Let's Encrypt` and Azure direct supported ones). Changing this forces a new resource to be created.
      })
      certificate_policy_key_properties = object({ #(Required) A `key_properties` block as defined below.
        key_properties_curve      = string         #(Optional) Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-256K`, `P-384`, and `P-521`. This field will be required in a future release if `key_type` is `EC` or `EC-HSM`. Changing this forces a new resource to be created.
        key_properties_exportable = bool           #(Required) Is this certificate exportable? Changing this forces a new resource to be created.
        key_properties_key_size   = number         #(Optional) The size of the key used in the certificate. Possible values include `2048`, `3072`, and `4096` for `RSA` keys, or `256`, `384`, and `521` for `EC` keys. This property is required when using RSA keys. Changing this forces a new resource to be created.
        key_properties_key_type   = string         #(Required) Specifies the type of key. Possible values are `EC`, `EC-HSM`, `RSA`, `RSA-HSM` and `oct`. Changing this forces a new resource to be created.
        key_properties_reuse_key  = bool           #(Required) Is the key reusable? Changing this forces a new resource to be created.
      })
      certificate_policy_lifetime_action = object({ #(Optional) A `lifetime_action` block as defined below.
        lifetime_action_action = object({           #(Required) A `action` block as defined below.
          action_type = string                      #(Required) The Type of action to be performed when the lifetime trigger is triggerec. Possible values include `AutoRenew` and `EmailContacts`. Changing this forces a new resource to be created.
        })
        lifetime_action_trigger = object({     #(Required) A `trigger` block as defined below.
          trigger_days_before_expiry  = number #(Optional) The number of days before the Certificate expires that the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `lifetime_percentage`.
          trigger_lifetime_percentage = number #(Optional) The percentage at which during the Certificates Lifetime the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with `days_before_expiry`.
        })
      })
      certificate_policy_secret_properties = object({ #(Required) A `secret_properties` block as defined below.
        secret_properties_content_type = string       #(Required) The Content-Type of the Certificate, such as `application/x-pkcs12` for a PFX or `application/x-pem-file` for a PEM. Changing this forces a new resource to be created.
      })
      certificate_policy_x509_certificate_properties = object({          #(Optional) A `x509_certificate_properties` block as defined below. Required when `certificate` block is not specified.
        x509_certificate_properties_extended_key_usage = list(string)    #(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created.
        x509_certificate_properties_key_usage          = set(string)     #(Required) A list of uses associated with this Key. Possible values include `cRLSign`, `dataEncipherment`, `decipherOnly`, `digitalSignature`, `encipherOnly`, `keyAgreement`, `keyCertSign`, `keyEncipherment` and `nonRepudiation` and are case-sensitive. Changing this forces a new resource to be created.
        x509_certificate_properties_subject            = string          #(Required) The Certificate's Subject. Changing this forces a new resource to be created.
        x509_certificate_properties_validity_in_months = number          #(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created.
        x509_certificate_properties_subject_alternative_names = object({ #(Optional) A `subject_alternative_names` block as defined below. Changing this forces a new resource to be created.
          subject_alternative_names_dns_names = set(string)              #(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_emails    = set(string)              #(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created.
          subject_alternative_names_upns      = set(string)              #(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created.
        })
      })
    })
    key_vault_certificate_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default     = {}
  description = "Map of Key Vault Certificate variables"
}

#DISK ENCRYPTION SET VARIABLES
variable "disk_encryption_set_variables" {
  type = map(object({
    disk_encryption_set_name                          = string #(Required) The name of the Disk Encryption Set. Changing this forces a new resource to be created
    disk_encryption_set_resource_group_name           = string #(Required) Specifies the name of the Resource Group where the Disk Encryption Set should exist. Changing this forces a new resource to be created.
    disk_encryption_set_location                      = string #(Required) Specifies the Azure Region where the Disk Encryption Set exists. Changing this forces a new resource to be created.
    disk_encryption_set_key_vault_name                = string #(Required) Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret).
    disk_encryption_set_key_vault_key_name            = string #(Required) Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret).
    disk_encryption_set_key_vault_resource_group_name = string #(Required) key vault resource group name
    disk_encryption_set_auto_key_rotation_enabled     = bool   #(Optional) Boolean flag to specify whether Azure Disk Encryption Set automatically rotates encryption Key to latest version. Defaults to false
    disk_encryption_set_encryption_type               = string #(Optional) The type of key used to encrypt the data of the disk. Possible values are EncryptionAtRestWithCustomerKey, EncryptionAtRestWithPlatformAndCustomerKeys and ConfidentialVmEncryptedWithCustomerKey. Defaults to EncryptionAtRestWithCustomerKey.
    disk_encryption_set_federated_client_id           = string #(Optional) Multi-tenant application client id to access key vault in a different tenant.
    disk_encryption_set_identity = object({
      disk_encryption_set_identity_type = string     #(Required) The type of Managed Service Identity that is configured on this Disk Encryption Set. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      disk_encryption_set_identities = list(object({ #(Optional) Optional) A list of User Assigned Managed Identity IDs to be assigned to this Disk Encryption Set. Note: This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        user_identity_name                = string   #user assigned identity name Required if identity type ="userassigned" or "systemassigned,userassigned"
        user_identity_resource_group_name = string   #resource group name of the user identity
      }))
    })
    disk_encryption_set_tags = map(string) #(Optional) A mapping of tags which should be assigned to the disk encryption set.
  }))
  default     = {}
  description = "Map of variables for disk encryption set"
}

#CAPACITY RESERVATION GROUP VARIABLES
variable "capacity_reservation_group_variables" {
  type = map(object({
    capacity_reservation_group_name                = string       #(Required) Specifies the name of this Capacity Reservation Group. Changing this forces a new resource to be created.
    capacity_reservation_group_resource_group_name = string       #(Required) Specifies the name of the resource group the Capacity Reservation Group is located in. Changing this forces a new resource to be created.
    capacity_reservation_group_location            = string       #(Required) The Azure location where the Capacity Reservation Group exists. Changing this forces a new resource to be created.
    capacity_reservation_group_zones               = list(string) #(Optional) Specifies a list of Availability Zones for this Capacity Reservation Group. Changing this forces a new resource to be created.
    capacity_reservation_group_tags                = map(string)  #(Optional) A mapping of tags to assign to the resource.
  }))
  description = "Map of capacity reservation group variables"
  default     = {}
}

#SHARED IMAGE GALLERY VARIABLES
variable "shared_image_gallery_variables" {
  type = map(object({
    shared_image_gallery_name                = string #(Required) Specifies the name of the Shared Image Gallery.
    shared_image_gallery_resource_group_name = string #(Required) The name of the resource group in which to create the Shared Image Gallery.
    shared_image_gallery_location            = string #(Required) Specifies the supported Azure location where the resource exists.
    shared_image_gallery_description         = string #(Optional) A description for this Shared Image Gallery.
    shared_image_gallery_sharing = object({
      sharing_permission = string #(Required) The permission of the Shared Image Gallery when sharing. The only possible value now is Community. Changing this forces a new resource to be created.
      sharing_community_gallery = object({
        community_gallery_eula            = string #(Required) The End User Licence Agreement for the Shared Image Gallery. Changing this forces a new resource to be created.
        community_gallery_prefix          = string #(Required) Prefix of the community public name for the Shared Image Gallery. Changing this forces a new resource to be created.
        community_gallery_publisher_email = string #(Required) Email of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.
        community_gallery_publisher_uri   = string #(Required) URI of the publisher for the Shared Image Gallery. Changing this forces a new resource to be created.
      })
    })

    shared_image_gallery_tags = map(string) #(Optional) A mapping of tags to assign to the Shared Image Gallery.
  }))
  description = "Map of Shared Image Gallery"
  default     = {}
}

#GALLERY APPLICATION VARIABLES
variable "gallery_application_variables" {
  type = map(object({
    gallery_application_name                                     = string      #(Required) The name of the Gallery Application. Changing this forces a new resource to be created.
    gallery_application_shared_image_gallery_name                = string      #(Required) The name of the gallery application shared image gallery name
    gallery_application_shared_image_gallery_resource_group_name = string      #(Required) The name of the gallery application shared image gallery resource group name
    gallery_application_location                                 = string      #(Required) The Azure Region where the Gallery Application exists. Changing this forces a new resource to be created.
    gallery_application_supported_os_type                        = string      #(Required) The type of the Operating System supported for the Gallery Application. Possible values are Linux and Windows. Changing this forces a new resource to be created.
    gallery_application_description                              = string      # (Optional) A description of the Gallery Application.
    gallery_application_end_of_life_date                         = string      #(Optional) The end of life date in RFC3339 format of the Gallery Application.
    gallery_application_eula                                     = string      # (Optional) The End User Licence Agreement of the Gallery Application.
    gallery_application_privacy_statement_uri                    = string      #(Optional) The URI containing the Privacy Statement associated with the Gallery Application.
    gallery_application_release_note_uri                         = string      #(Optional) The URI containing the Release Notes associated with the Gallery Application.
    gallery_application_tags                                     = map(string) #(Optional) A mapping of tags to assign to the Gallery Application.
  }))
  description = "Map of gallery application"
  default     = {}
}

#STORAGE ACCOUNT VARIABLES
variable "storage_account_variables" {
  type = map(object({
    storage_account_key_vault_name                                     = string #(Required) The name of the Key Vault.
    storage_account_key_vault_resource_group_name                      = string #(Required) The resource group name of the Key Vault.
    storage_account_key_vault_key_name                                 = string #(Required) The name of the Key Vault key required for customer managed key.
    storage_account_user_assigned_identity_name_for_cmk                = string #(Required) The name of a user assigned identity for customer managed key.
    storage_account_user_assigned_identity_resource_group_name_for_cmk = string #(Required) The resource group name of a user assigned identity for customer managed key.
    storage_account_identity_type_for_cmk                              = string #(Required) The identity type of a user assigned identity for customer managed key. Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned".
    storage_account_name                                               = string #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = string #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = string #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = string #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = string #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = string #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
    storage_account_cross_tenant_replication_enabled                   = bool   #(Optional) Should cross Tenant replication be enabled? Defaults to true.
    storage_account_access_tier                                        = string #(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot.
    storage_account_edge_zone                                          = string #(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist.
    storage_account_enable_https_traffic_only                          = bool   #(Optional) Boolean flag which forces HTTPS if enabled. Defaults to true.
    storage_account_min_tls_version                                    = string #(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts.
    storage_account_allow_nested_items_to_be_public                    = bool   #Allow or disallow nested items within this Account to opt into being public. Defaults to true.
    storage_account_shared_access_key_enabled                          = bool   #Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true.
    storage_account_public_network_access_enabled                      = bool   #(Optional) Whether the public network access is enabled? Defaults to true.
    storage_account_default_to_oauth_authentication                    = bool   #(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false
    storage_account_allowed_copy_scope                                 = string #(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.
    storage_account_is_hns_enabled                                     = bool   #(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    storage_account_nfsv3_enabled                                      = bool   #(Optional) Is NFSv3 protocol enabled? Defaults to false.
    storage_account_large_file_share_enabled                           = bool   #(Optional) Is Large File Share Enabled?
    storage_account_queue_encryption_key_type                          = string #(Optional) The encryption type of the queue service. Possible values are Service and Account.Default value is Service.
    storage_account_table_encryption_key_type                          = string #(Optional) The encryption type of the table service. Possible values are Service and Account. Default value is Service.
    storage_account_infrastructure_encryption_enabled                  = bool   #(Optional) Is infrastructure encryption enabled? Defaults to false.
    storage_account_sftp_enabled                                       = bool   #(Optional) Boolean, enable SFTP for the storage account, to enable this, is_hns_enabled should be true as well
    storage_account_custom_domain = object({
      custom_domain_name          = string #(Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
      custom_domain_use_subdomain = bool   #(Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
    })

    storage_account_identity = object({
      storage_account_identity_type = string # Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
      storage_account_user_assigned_identity_ids = list(object({
        identity_name                = string
        identity_resource_group_name = string
      }))
    })

    storage_account_blob_properties = object({
      versioning_enabled            = bool   #(Optional) Is versioning enabled? Default to false.
      change_feed_enabled           = bool   #(Optional) Is the blob service properties for change feed events enabled? Default to false.
      change_feed_retention_in_days = number #(Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
      default_service_version       = string #(Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.
      last_access_time_enabled      = bool   #(Optional) Is the last access time based tracking enabled? Default to false.

      cors_enabled = bool #(optional) Should cross origin resource sharing be enabled
      cors_rule = object({
        allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      })
      restore_policy = object({
        restore_policy_days = string #(Required) Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.
      })
      delete_retention_policy = object({
        delete_retention_policy_days = string #(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
      })

      container_delete_retention_policy = object({
        container_delete_retention_policy_days = string #(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
      })
    })

    storage_account_queue_properties = object({
      cors_enabled = bool #(optional) Should cross origin resource sharing be enabled.
      cors_rule = object({
        allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      })

      logging_enabled = bool #Should storage account queue properties logging be enabled.
      logging = object({
        delete                = bool   #(Required) Indicates whether all delete requests should be logged. 
        read                  = bool   #(Required) Indicates whether all read requests should be logged. 
        version               = string #(Required) The version of storage analytics to configure.
        write                 = bool   #(Required) Indicates whether all write requests should be logged.
        retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      })

      minute_metrics = object({
        enabled               = bool   #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = string #(Required) The version of storage analytics to configure. 
        include_apis          = bool   #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      })

      hour_metrics = object({
        enabled               = bool   #(Required) Indicates whether minute metrics are enabled for the Queue service. 
        version               = string #(Required) The version of storage analytics to configure. 
        include_apis          = bool   #(Optional) Indicates whether metrics should generate summary statistics for called API operations.
        retention_policy_days = number #(Optional) Specifies the number of days that logs will be retained.
      })
    })

    storage_account_static_website = object({
      index_document     = string #Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
      error_404_document = string #(Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
    })

    storage_account_share_properties = object({
      cors_enabled = bool #(optional) Should cross origin resource sharing be enabled.
      cors_rule = object({
        allowed_headers    = list(string) #(Required) A list of headers that are allowed to be a part of the cross-origin request.
        allowed_methods    = list(string) #(Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
        allowed_origins    = list(string) #(Required) A list of origin domains that will be allowed by CORS.
        exposed_headers    = list(string) #(Required) A list of response headers that are exposed to CORS clients.
        max_age_in_seconds = number       #(Required) The number of seconds the client should cache a preflight response.
      })

      retention_policy = object({
        retention_policy_days = number #(Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
      })

      smb = object({
        smb_versions                        = set(string) #(Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
        smb_authentication_types            = set(string) #(Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
        smb_kerberos_ticket_encryption_type = set(string) #(Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
        smb_channel_encryption_type         = set(string) #(Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
        smb_multichannel_enabled            = bool        #(Optional) Indicates whether multichannel is enabled. Defaults to false. This is only supported on Premium storage accounts.
      })
    })

    storage_account_network_rules = object({
      default_action = string       #(Required) Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
      bypass         = list(string) #(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      ip_rules       = list(string) #(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.

      storage_account_network_rules_vnet_subnets = list(object({
        storage_account_network_rules_virtual_network_name = string #(Required) Vitural Network name to be associated.
        storage_account_network_rules_subnet_name          = string #(Required) Subnet Name to be associated.
        storage_account_network_rules_vnet_subscription_id = string #(Required) Subscription Id where Vnet is created.
        storage_account_network_rules_vnet_rg_name         = string #(Required) Resource group where Vnet is created.
      }))

      private_link_access = map(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = string
      }))
    })

    storage_account_azure_files_authentication = object({
      directory_type = string #(Required) Specifies the directory service used. Possible values are AADDS and AD.
      active_directory = object({
        storage_sid         = string #(Required) Specifies the security identifier (SID) for Azure Storage.
        domain_name         = string #(Required) Specifies the primary domain that the AD DNS server is authoritative for.
        domain_sid          = string #(Required) Specifies the security identifier (SID).
        domain_guid         = string #(Required) Specifies the domain GUID.
        forest_name         = string #(Required) Specifies the Active Directory forest.
        netbios_domain_name = string #(Required) Specifies the NetBIOS domain name.
      })
    })

    storage_account_routing = object({
      publish_internet_endpoints  = bool   #(Optional) Should internet routing storage endpoints be published? Defaults to false.
      publish_microsoft_endpoints = bool   #(Optional) Should Microsoft routing storage endpoints be published? Defaults to false.
      choice                      = string #(Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
    })

    storage_account_immutability_policy = object({
      allow_protected_append_writes = bool   #(Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
      state                         = string #(Required) Defines the mode of the policy. Disabled state disables the policy, Unlocked state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, Locked state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.
      period_since_creation_in_days = number #(Required) The immutability period for the blobs in the container since the policy creation, in days.
    })

    storage_account_sas_policy = object({
      expiration_period = string #(Required) The SAS expiration period in format of DD.HH:MM:SS.
      expiration_action = string #(Optional) The SAS expiration action. The only possible value is Log at this moment. Defaults to Log.
    })

    storage_account_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default     = {}
  description = "Map of object of storage account variables"
}

#STORAGE CONTAINER VARIABLES
variable "storage_container_variables" {
  type = map(object({
    storage_container_name                  = string      #Required The name of the Container which should be created within the Storage Account.
    storage_container_storage_account_name  = string      #Required The name of the Storage Account where the Container should be created.
    storage_container_container_access_type = string      #Optional The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private.
    storage_container_metadata              = map(string) #Optional A mapping of MetaData for this Container. All metadata keys should be lowercase.
  }))
  default     = {}
  description = "Map of object of storage container variables"
}

#STORAGE BLOB VARIABLES
variable "storage_blob_variables" {
  type = map(object({
    storage_blob_name                   = string      #(Required) The name of the storage blob. Must be unique within the storage container the blob is located.
    storage_blob_storage_account_name   = string      #(Required) Specifies the storage account in which to create the storage container. Changing this forces a new resource to be created.
    storage_blob_storage_container_name = string      #(Required) The name of the storage container in which this blob should be created.
    storage_blob_type                   = string      #(Required) The type of the storage blob to be created. Possible values are Append, Block or Page. Changing this forces a new resource to be created.
    storage_blob_size                   = number      #(Optional) Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512. Defaults to 0.
    storage_blob_content_type           = string      #(Optional) The content type of the storage blob. Cannot be defined if source_uri is defined. Defaults to application/octet-stream.
    storage_blob_source                 = string      #(Optional) An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source_content or source_uri is specified.
    storage_blob_source_uri             = string      #(Optional) The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created. Changing this forces a new resource to be created. This field cannot be specified for Append blobs and cannot be specified if source or source_content is specified.
    storage_blob_access_tier            = string      #(Optional) The access tier of the storage blob. Possible values are Archive, Cool and Hot.
    storage_blob_cache_control          = string      #(Optional) Controls the cache control header content of the response when blob is requested .
    storage_blob_content_md5            = string      #(Optional) The MD5 sum of the blob contents. Cannot be defined if source_uri is defined, or if blob type is Append or Page. Changing this forces a new resource to be created.
    storage_blob_source_content         = string      #(Optional) The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source_uri is specified.
    storage_blob_parallelism            = number      #(Optional) The number of workers per CPU core to run for concurrent uploads. Defaults to 8.
    storage_blob_metadata               = map(string) #(Optional) A map of custom blob metadata.
  }))
  default     = {}
  description = "Map of object of storage blob variables"
}

#GALLERY APPLICATION VERSION VARIABLES
variable "gallery_application_version_variables" {
  type = map(object({
    gallery_application_version_name                                     = string #(Required) The version name of the Gallery Application Version, such as 1.0.0. Changing this forces a new resource to be created.
    gallery_application_version_shared_image_gallery_name                = string #(Required) The name of the Shared Image Gallery.
    gallery_application_version_shared_image_gallery_resource_group_name = string #(Required) The name of the Resource Group in which the Shared Image Gallery exists.
    gallery_application_version_gallery_application_name                 = string #(Required) The name of the Gallery Application.
    gallery_application_version_storage_account_name                     = string #(Required) The name of the Storage Account where the Container exists.
    gallery_application_version_storage_container_name                   = string #(Required) The name of the Storage Container where the Blob exists.
    gallery_application_version_storage_blob_name                        = string #(Required) The name of the Storage Blob.
    gallery_application_version_location                                 = string #(Required) The Azure Region where the Gallery Application Version exists. Changing this forces a new resource to be created.
    gallery_application_version_enable_health_check                      = bool   #(Optional) Should the Gallery Application reports health. Defaults to false.
    gallery_application_version_end_of_life_date                         = string #(Optional) The end of life date in RFC3339 format of the Gallery Application Version.
    gallery_application_version_exclude_from_latest                      = bool   #(Optional) Should the Gallery Application Version be excluded from the latest filter? If set to true this Gallery Application Version won't be returned for the latest version. Defaults to false.

    gallery_application_version_manage_action = object({ #(Required) A manage_action block as defined below.
      manage_action_install = string                     #(Required) The command to install the Gallery Application. Changing this forces a new resource to be created.
      manage_action_remove  = string                     #(Required) The command to remove the Gallery Application. Changing this forces a new resource to be created.
      manage_action_update  = string                     #(Optional) The command to update the Gallery Application. Changing this forces a new resource to be created.
    })

    gallery_application_version_source = object({ #(Required) A source block as defined below.
      source_default_configuration_link = string  # (Optional)The Storage Blob URI of the default configuration. Changing this forces a new resource to be created.
    })

    gallery_application_version_target_region = object({ #(Required) One or more target_region blocks as defined below.
      target_region_name                   = string      #(Required) The Azure Region in which the Gallery Application Version exists.
      target_region_regional_replica_count = number      #(Required) The number of replicas of the Gallery Application Version to be created per region. Possible values are between 1 and 10.
      target_region_storage_account_type   = string      #(Optional) The storage account type for the Gallery Application Version. Possible values are Standard_LRS, Premium_LRS and Standard_ZRS. Defaults to Standard_LRS.
    })

    gallery_application_version_tags = map(string) #(Optional) A mapping of tags to assign to the Gallery Application Version.
  }))
  description = "Map of Gallery Application Version Variables"
  default     = {}
}

#NETWORK INTERFACE VARIABLES
variable "network_interface_variables" {
  type = map(object({
    network_interface_name                          = string       #(Required) The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_location                      = string       #(Required) The location where the Network Interface should exist. Changing this forces a new resource to be created.
    network_interface_resource_group_name           = string       #(Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.
    network_interface_auxiliary_mode                = string       # (Optional) Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs). Possible values are AcceleratedConnections and Floating.
    network_interface_auxiliary_sku                 = string       # (Optional) Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs). Possible values are A1, A2, A4 and A8.
    network_interface_dns_servers                   = list(string) #(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. 
    network_interface_edge_zone                     = string       #(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created.
    network_interface_enable_ip_forwarding          = bool         #Optional)  Should IP Forwarding be enabled? Defaults to false
    network_interface_enable_accelerated_networking = bool         #(Optional) Should Accelerated Networking be enabled? Defaults to false
    network_interface_internal_dns_label            = string       #(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.
    network_interface_ip_configuration = map(object({              #(Required) One or more ip_configuration blocks
      ip_configuration_name                          = string      #(Required) A name used for this IP Configuration. Changing this forces a new resource to be created.
      ip_configuration_private_ip_address_allocation = string      #(Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static.
      ip_configuration_private_ip_address            = string      #(Optional) When private_ip_address_allocation is set to Static, The Static IP Address which should be used
      ip_configuration_private_ip_address_version    = string      #(Optional) The IP Version to use. Possible values are IPv4 or IPv6.Defaults to IPv4.
      ip_configuration_subnet = object({                           #(Required) When private_ip_address_version is set to IPv4,The ID of the Subnet where this Network Interface should be located in.
        subnet_virtual_network_name                = string        #(Required) When private_ip_address_version is set to IPv4,The virtual_network_name is required to fetch subnet ID.
        subnet_name                                = string        #(Required) When private_ip_address_version is set to IPv4,The subnet_name is required to fetch subnet ID.
        subnet_virtual_network_resource_group_name = string        #(Required) When private_ip_address_version is set to IPv4,The virtual network resource group name  is required to fetch subnet ID.
      })
      ip_configuration_public_ip = object({    #(Optional) Reference to a Public IP Address to associate with this NIC
        public_ip_name                = string #(Optional) Reference to a Public IP Address Name to associate with this NIC
        public_ip_resource_group_name = string #(Optional) Reference to a Public IP Address Name Resource Group Name to associate with this NIC
      })
      ip_configuration_primary = bool              #(Optional) Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false
      ip_configuration_load_balancer = object({    #(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
        load_balancer_name                = string #(Optional) The Load Balancer name is required to fetch the Load Balancer ID.
        load_balancer_resource_group_name = string #(Optional) The Load Balancer Resource Group name is required to fetch the Load Balancer ID
      })
    }))
    network_interface_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
  }))
  default     = {}
  description = "Map of Network interface"
}

#NETWORK SECURITY GROUP VARIABLES
variable "network_security_group_variables" {
  type = map(object({
    network_security_group_name                = string                           # (Required) Specifies the name of the network security group
    network_security_group_resource_group_name = string                           # (Required) The name of the resource group in which to create the network security group
    network_security_group_location            = string                           # (Required) Specifies the supported Azure location where the resource exists
    network_security_group_security_rule = map(object({                           # (Optional) List of objects representing security rules
      security_rule_name                                           = string       # (Required) The name of the security rule
      security_rule_application_security_group_resource_group_name = string       # (Optional) The resource group name of the application security group
      security_rule_description                                    = string       # (Optional) A description for this rule. Restricted to 140 characters 
      security_rule_protocol                                       = string       # (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
      security_rule_source_port_range                              = string       # (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
      security_rule_source_port_ranges                             = list(string) # (Optional) List of source ports or port ranges. This is required if source_port_range is not specified
      security_rule_destination_port_range                         = string       # (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
      security_rule_destination_port_ranges                        = list(string) # (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
      security_rule_source_address_prefix                          = string       # (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified
      security_rule_source_address_prefixes                        = list(string) # (Optional) Tags may not be used. This is required if source_address_prefix is not specified.
      security_rule_source_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                                                       # (Optional) A list of source application security group ids
      security_rule_destination_address_prefix   = string       # (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified.
      security_rule_destination_address_prefixes = list(string) # (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified
      security_rule_destination_application_security_group_names = map(object({
        application_security_group_name                = string
        application_security_group_resource_group_name = string
      }))                              # (Optional) A list of destination application security group ids
      security_rule_access    = string # (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny
      security_rule_priority  = string # (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule
      security_rule_direction = string # (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound
    }))
    network_security_group_tags = map(string) #(Optional) A mapping of tags which should be assigned to the Network Security Group.
  }))
  description = "Map of object for network security group details"
  default     = {}
}

#NETWORK INTERFACE SECURITY GROUP ASSOCIATION
variable "network_interface_security_group_association_variables" {
  type = map(object({
    network_interface_security_group_association_network_interface_name                     = string # (Required) The name of the Network Interface. Changing this forces a new resource to be created.
    network_interface_security_group_association_network_interface_resource_group_name      = string # (Required) The ID of the Network Interface. Changing this forces a new resource to be created.
    network_interface_security_group_association_network_security_group_name                = string # (Required) The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created.
    network_interface_security_group_association_network_security_group_resource_group_name = string # (Required) The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created.
  }))
  description = "Map of network interface security group association"
  default     = {}
}

#SUBNET NETWORK SECURITY GROUP ASSOCIATION VARIABLES
variable "subnet_network_security_group_association_variables" {
  type = map(object({
    subnet_network_security_group_association_subnet_name                                = string #(Required)Subnet name for network security group association
    subnet_network_security_group_association_virtual_network_name                       = string #(Required)Virtual network name for subnet network security group association
    subnet_network_security_group_association_subnet_resource_group_name                 = string #(Required)Name of subnet for creating nsg group association
    subnet_network_security_group_association_network_security_group_name                = string #(Required)Name of Network Security group for subnet association
    subnet_network_security_group_association_network_security_group_resource_group_name = string #(Required)Resource group name for network security group association
  }))
  description = "Map of Subnet Network security group assocication variables"
  default     = {}
}

#LINUX VM VARIABLES
variable "linux_virtual_machine_variables" {
  type = map(object({
    linux_virtual_machine_admin_username = string #(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_location       = string #(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
    linux_virtual_machine_license_type   = string #(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS.
    linux_virtual_machine_name           = string #(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_os_disk = object({      #(Required) A os_disk block as defined below.
      os_disk_caching              = string       #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
      os_disk_storage_account_type = string       #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.
      os_disk_diff_disk_settings = object({       #(Optional) A diff_disk_settings block as defined above. Changing this forces a new resource to be created.
        diff_disk_settings_option    = string     # (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is Local. Changing this forces a new resource to be created.
        diff_disk_settings_placement = string     #(Optional) Specifies where to store the Ephemeral Disk. Possible values are CacheDisk and ResourceDisk. Defaults to CacheDisk. Changing this forces a new resource to be created.
      })
      os_disk_disk_size_gb              = number #(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
      os_disk_name                      = string #(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
      os_disk_security_encryption_type  = string #(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are VMGuestStateOnly and DiskWithVMGuestState. Changing this forces a new resource to be created.
      os_disk_write_accelerator_enabled = bool   #(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to false.
    })
    linux_virtual_machine_resource_group_name = string       #(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
    linux_virtual_machine_size                = string       #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2.
    linux_virtual_machine_additional_capabilities = object({ #(Optional) A additional_capabilities block as defined below.
      additional_capabilities_ultra_ssd_enabled = bool       #(Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
    })
    linux_virtual_machine_allow_extension_operations      = bool   #(Optional) Should Extension Operations be allowed on this Virtual Machine?
    linux_virtual_machine_computer_name                   = string #(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created.
    linux_virtual_machine_custom_data                     = string #(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created.
    linux_virtual_machine_disable_password_authentication = bool   #(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_edge_zone                       = string #(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_encryption_at_host_enabled      = bool   #(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?
    linux_virtual_machine_eviction_policy                 = string #(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created.
    linux_virtual_machine_extensions_time_budget          = string #(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M).
    linux_virtual_machine_gallery_application = object({           #(Optional) A gallery_application block as defined below.
      gallery_application_order = number                           #(Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647.
      gallery_application_tag   = string                           #(Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
    })
    linux_virtual_machine_identity = object({                        #(Optional)
      identity_type = string                                         #(Required) Other values could be "UserAssigned", "SystemAssigned".If given as "SystemAssigned" , then give below parameter as null      
      linux_virtual_machine_user_assigned_identities = list(object({ #(Optional)
        user_assigned_identities_name                = string        #(Required)Name of the user assigned identity
        user_assigned_identities_resource_group_name = string        #(Required)Resource group name of the user assigned identity
      }))
    })
    linux_virtual_machine_patch_assessment_mode = string #(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault.
    linux_virtual_machine_patch_mode            = string # (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see the product documentation.
    linux_virtual_machine_max_bid_price         = string #(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons.
    linux_virtual_machine_plan = list(object({           #(Optional) A plan block as defined below. Changing this forces a new resource to be created.
      plan_name      = string                            #(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_product   = string                            #(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      plan_publisher = string                            #(Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
    }))
    linux_virtual_machine_platform_fault_domain = string    #(Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_priority              = string    #(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created.
    linux_virtual_machine_provision_vm_agent    = bool      #(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created.
    linux_virtual_machine_secure_boot_enabled   = bool      #(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_source_image_reference = object({ #Optional) A source_image_reference block as defined below. Changing this forces a new resource to be created.
      source_image_reference_publisher = string             #(Optional) Specifies the publisher of the image used to create the virtual machines.
      source_image_reference_offer     = string             #(Optional) Specifies the offer of the image used to create the virtual machines.
      source_image_reference_sku       = string             #(Optional) Specifies the SKU of the image used to create the virtual machines.
      source_image_reference_version   = string             #(Optional) Specifies the version of the image used to create the virtual machines.
    })
    linux_virtual_machine_termination_notification = list(object({ #(Optional) A termination_notification block as defined below.
      termination_notification_enabled = bool                      #(Required) Should the termination notification be enabled on this Virtual Machine? Defaults to false.
      termination_notification_timeout = string                    #(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format.
    }))
    linux_virtual_machine_user_data    = string      #(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine.
    linux_virtual_machine_vtpm_enabled = bool        #(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created.
    linux_virtual_machine_zone         = string      #(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
    linux_virtual_machine_tags         = map(string) #(Optional) A mapping of tags which should be assigned to this Virtual Machine.

    linux_virtual_machine_use_existing_vm_username        = bool   #(Required)should be set true if existing user name is used
    linux_virtual_machine_generate_new_admin_password     = bool   #(Required)admin_password should be generated if disable_password_authentication is false
    linux_virtual_machine_generate_new_ssh_key            = bool   #(Required)Should be true/false if linux_virtual_machine_disable_password_authentication is true
    linux_virtual_machine_admin_login_key_vault_name      = string #"existingkeyvaultscenario"
    linux_virtual_machine_tls_private_key_algorithm       = string #Provide Algorithm used for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_tls_private_key_rsa_bits        = number #Provide number if bits for TLS private key if linux_virtual_machine_generate_new_ssh_key is true
    linux_virtual_machine_admin_ssh_key_vault_secret_name = string #Key vault secret name to store the ssh key if linux_virtual_machine_generate_new_ssh_key is true

    linux_virtual_machine_is_disk_encryption_set_required = bool #(Required)Boolean value if disk encryption set is required or not
    linux_virtual_machine_is_vmss_id_required             = bool #(Required)Boolean value if VMSS id is required
    linux_virtual_machine_network_interface = map(object({       #(Required) Map of object for network interface
      network_interface_name                = string             #(Required)Name of the network interface
      network_interface_resource_group_name = string             #(Required)Resource group name of network interface
    }))
    linux_virtual_machine_is_secret_required                                     = bool   #(Required)Boolean value if secret is required or not
    linux_virtual_machine_is_storage_blob_required                               = bool   #(Required)Boolean value if blob storage is required
    linux_virtual_machine_storage_blob_name                                      = string #Provide blob storage name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_storage_account_name                                   = string #Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_storage_container_name                                 = string #Provide storage container name value if linux_virtual_machine_is_storage_blob_required is set to true.
    linux_virtual_machine_is_gallery_application_id_required                     = bool   #(Required)Boolean value if gallery application id is required
    linux_virtual_machine_gallery_application_version_name                       = string #Provide version name if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_shared_image_gallery_name                              = string #Name of the shared image gallery. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_gallery_application_name                               = string #Name of gallery application. #Provide value if linux_virtual_machine_is_gallery_application_id_required is set to true
    linux_virtual_machine_is_capacity_reservation_group_id_required              = bool   #(Required)Boolean value if capacity reservation group id is required
    linux_virtual_machine_capacity_reservation_group_name                        = string #Provide capacity reservation group name if linux_virtual_machine_is_capacity_reservation_group_id_required is set to true
    linux_virtual_machine_is_key_vault_certificate_url_required                  = bool   #(Required)Boolean value if key vault certificate url is required
    linux_virtual_machine_key_vault_certificate_name                             = string #Provide key vault certificate name if linux_virtual_machine_is_key_vault_certificate_url_required is set to true
    linux_virtual_machine_disk_encryption_set_name                               = string #Name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_is_boot_diagnostics_required                           = bool   #(Required)Boolean value if boot diagnostics required
    linux_virtual_machine_bypass_platform_safety_checks_on_user_schedule_enabled = bool   #(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false.Can only be set to true when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_availability_set_id_required                        = bool   #(Required)Boolean value if availability set id required
    linux_virtual_machine_is_proximity_placement_group_id_required               = bool   #(Required)Boolean value if proximity placement group id required
    linux_virtual_machine_reboot_setting                                         = string # (Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never. can only be set when patch_mode is set to AutomaticByPlatform.
    linux_virtual_machine_is_dedicated_host_group_id_required                    = bool   #(Required)Boolean value if dedicated host group id required
    linux_virtual_machine_is_dedicated_host_id_required                          = bool   #(Required)Boolean value if dedicated host id required
    linux_virtual_machine_boot_diagnostics_storage_account_name                  = string # Provide storage account name value if linux_virtual_machine_is_storage_blob_required or linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_deploy_vm_using_source_image_reference                 = bool   #(Required)Boolean value if VM should be deployed using source image reference
    linux_virtual_machine_availability_set_name                                  = string # Provide availability set name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_availability_set_resource_group_name                   = string # Provide availability set resource group name if linux_virtual_machine_is_availability_set_id_required is set true
    linux_virtual_machine_dedicated_host_group_name                              = string # Provide host group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_group_resource_group_name               = string # Provide host group resource group name if linux_virtual_machine_is_dedicated_host_group_id_required is set true
    linux_virtual_machine_dedicated_host_name                                    = string # Provide host name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_dedicated_host_resource_group_name                     = string # Provide host resource group name if linux_virtual_machine_is_dedicated_host_id_required is set true
    linux_virtual_machine_proximity_placement_group_name                         = string # Provide proximity palcement group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_proximity_placement_group_resource_group_name          = string # Provide proximity palcement group resource group name if linux_virtual_machine_is_proximity_placement_group_id_required is set true
    linux_virtual_machine_generated_admin_password_secret_name                   = string #Provide Key vault secret name to store random password if linux_virtual_machine_generate_new_admin_password is true
    linux_virtual_machine_existing_admin_password_secret_name                    = string #Provide Key vault secret name where the existing password exists if linux_virtual_machine_generate_new_admin_password is false
    linux_virtual_machine_virtual_machine_scale_set_name                         = string #Provide Vm scale set name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_virtual_machine_scale_set_resource_group_name          = string #Provide VM scale set resource group name if linux_virtual_machine_is_vmss_id_required is true
    linux_virtual_machine_source_image_type                                      = string #if you are using existing vm image make image type as "VMImage" if you are using share image give as "SharedImage"
    linux_virtual_machine_shared_image_name                                      = string #Provide image name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_shared_image_resource_group_name                       = string #Provide image resource group name if linux_virtual_machine_source_image_type is "SharedImage"
    linux_virtual_machine_existing_image_name                                    = string #Provide image name if linux_virtual_machine_source_image_type is "VMImage"
    linux_virtual_machine_existing_image_resource_group_name                     = string #Provide existing image resource group name if image type is "VMImage"
    linux_virtual_machine_admin_key_vault_resource_group_name                    = string #Provide key vault resource group name to store credentials
    linux_virtual_machine_storage_account_resource_group_name                    = string #Provide value if linux_virtual_machine_is_boot_diagnostics_required is set to true
    linux_virtual_machine_disk_encryption_set_resource_group_name                = string #Resource group name of the disk encryption set. Provide value if linux_virtual_machine_is_disk_encryption_set_required is set to true
    linux_virtual_machine_existing_admin_username_secret_name                    = string #Provide Key vault secret name to store admin username. Provide value if linux_virtual_machine_use_existing_vm_username is set to true.
    linux_virtual_machine_generated_admin_password_secret_expiration_date        = string
    linux_virtual_machine_generated_admin_password_secret_content_type           = string
    linux_virtual_machine_admin_ssh_key_vault_secret_expiration_date             = string
    linux_virtual_machine_admin_ssh_key_vault_secret_content_type                = string
  }))
  description = "Map of object of Linux virtual machine variables"
  default     = {}
}