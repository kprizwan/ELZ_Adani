#KEY VAULT VARIABLES
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_resource_group_name                   = string       #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_location                              = string       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_enabled_for_disk_encryption           = bool         #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = bool         #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = bool         # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = bool         #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = string       #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = bool         #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
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

#PRIVATE ENDPOINT VARIABLES
variable "private_endpoint_variables" {
  type = map(object({
    private_endpoint_name                                = string #(Required) Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created.
    private_endpoint_resource_group_name                 = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_location                            = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_virtual_network_name                = string #The name of the network interface associated with the private_endpoint
    private_endpoint_virtual_network_resource_group_name = string #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.

    private_endpoint_subnet_name  = string #(Required) subnet in which private endpoint is hosting
    custom_network_interface_name = string #(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.

    private_endpoint_private_dns_zone_group = object({    #(Optional) A private_dns_zone_group block as defined below.
      private_dns_zone_group_name          = string       #(Required) Specifies the Name of the Private DNS Zone Group.
      private_dns_zone_names               = list(string) #(Required) Specifies the list of Private DNS Zones names to include within the private_dns_zone_group.These names will be fetched by the data resource of private_dns_zone name.
      private_dns_zone_resource_group_name = string       #(Required) Specifies the resource group name of Private DNS Zones to include within the private_dns_zone_group.This will be fetched by the data resource of private_dns_zone resource group name.
    })

    private_endpoint_private_service_connection = object({           #(Required) A private_service_connection block as defined below.
      private_service_connection_name                 = string       #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
      private_service_connection_is_manual_connection = bool         #(Required) set true if resource_alias != null
      private_connection_resource_name                = string       #(Optional) The Service Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_resource_group_name = string       #(Optional) The Service Resource Group Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_alias               = string       #(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      request_message                                 = string       #(Optional) Should be enabled if the is_manual_connection is set as true.  A message passed to the owner of the remote resource
      subresource_names                               = list(string) # (Optional) A list of subresource names which the Private Endpoint is able to connect to.
    })

    private_endpoint_ip_configuration = map(object({ # (Optional) One or more ip_configuration blocks as defined below. This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet.
      ip_configuration_name               = string   #(Required) Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
      ip_configuration_private_ip_address = string   #(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
      ip_configuration_subresource_name   = string   #(Optional) A list of subresource names which the Private Endpoint is able to connect to.
      ip_configuration_member_name        = string   #(Optional) Specifies the member name this IP address applies to. If it is not specified, it will use the value of subresource_name. Changing this forces a new resource to be created.
    }))

    private_endpoint_tags = map(string) #(Optional)A mapping of tags to assign to the resource.
  }))
  description = "Map of private endpoint objects. name, subnet_id, is_manual_connection, private_connection_resource_id and subresource_names supported"
  default     = {}
}


#PRIVATE DNS ZONE VARIABLES
variable "private_dns_zone_variables" {
  type = map(object({
    private_dns_zone_name                = string #(Required) The name of the Private DNS Zone. Must be a valid domain name.
    private_dns_zone_resource_group_name = string #(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
    private_dns_zone_soa_record = list(object({   #(Optional) An soa_record block as defined below. Changing this forces a new resource to be created.
      soa_record_email         = string           #(Required) The email contact for the SOA record.
      soa_record_expire_time   = number           #(Optional) The expire time for the SOA record. Defaults to 2419200.
      soa_record_minimum_ttl   = number           #(Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10.
      soa_record_refresh_time  = number           #(Optional) The refresh time for the SOA record. Defaults to 3600.
      soa_record_retry_time    = number           #(Optional) The retry time for the SOA record. Defaults to 300.
      soa_record_serial_number = number           #(optional) The serial number for the SOA record.
      soa_record_ttl           = number           #(Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.
      soa_record_tags          = map(string)      #(Optional) A mapping of tags to assign to the Record Set.
    }))
    private_dns_zone_tags = map(string)
  }))
  description = "Map of private dns zone"
  default     = {}
}

