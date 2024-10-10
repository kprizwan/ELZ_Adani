#KEY VAULT
key_vault_variables = {
  "key_vault_1" = {
    key_vault_name                                  = "sdplzmgmtdckv01"                                                                                                                                                                         #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_location                              = "Central India"                                                                                                                                                                                       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_resource_group_name                   = "sd-plz-management-rg"                                                                                                                                                                               #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_enabled_for_disk_encryption           = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = true                                                                                                                                                                                            #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = true                                                                                                                                                                                            # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = false                                                                                                                                                                                           #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = "7"                                                                                                                                                                                             #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = false                                                                                                                                                                                           #(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
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
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
    key_vault_network_acls_enabled        = true            #(Optional) A network_acls block as defined below to be enabled or disabled
    key_vault_network_acls_bypass         = "AzureServices" #(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.
    key_vault_network_acls_default_action = "Deny"          # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
    key_vault_network_acls_ip_rules       = null            # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.

    #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
    key_vault_network_acls_virtual_networks = [ #(Optional) One or more Subnet ID's which should be able to access this Key Vault.
      {
        key_vault_network_acls_virtual_networks_virtual_network_name    =  null                    #(Required) Vitural Network name to be associated.
        key_vault_network_acls_virtual_networks_subnet_name             =  null                    #(Required) Subnet Name to be associated.
        key_vault_network_acls_virtual_networks_subscription_id         =  null                    #(Required) Subscription Id where Vnet is created.
        key_vault_network_acls_virtual_networks_virtual_network_rg_name =  null                    #(Required) Resource group where Vnet is created.
      }
    ]
    key_vault_contact_information_enabled = false #(Optional) One or more contact block as defined below to be enabled or disabled.
    key_vault_contact_email               = null  #(Required) E-mail address of the contact.
    key_vault_contact_name                = null  #(Optional) Name of the contact.
    key_vault_contact_phone               = null  #(Optional) Phone number of the contact.

  }
}

#PRIVATE ENDPOINT
private_endpoint_variables = {
  "private_endpoint_1" = {

    private_endpoint_name                                = "sd-management-vault-pep-01" # (Required) private endpoint name
    private_endpoint_resource_group_name                 = "sd-plz-management-rg"              # (Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_location                            = "Central India"                       #  (Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created.
    private_endpoint_virtual_network_name                = "sd-plz-management-vnet"            #The name of the network interface associated with the private_endpoint
    private_endpoint_virtual_network_resource_group_name = "sd-plz-management-rg1"              #(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
    private_endpoint_subnet_name                         = "sd-plz-management-vnet-pe-snet-01"          # (Required) subnet in which private endpoint is hosting
    custom_network_interface_name                        = "sd-management-vault-pep-nic-01"    #(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.
    private_endpoint_private_dns_zone_group              = null                           #(Optional) A private_dns_zone_group block as defined below.
    #   {
    #   private_dns_zone_group_name          = "privatednszonegroup00001"                                 #(Required) Specifies the Name of the Private DNS Zone Group.
    #   private_dns_zone_names               = ["ploceuspdnszone000001.com", "ploceuspdnszone000002.com"] #(Required) Specifies the list of Private DNS Zones names to include within the private_dns_zone_group.These names will be fetched by the data resource of private_dns_zone name.
    #   private_dns_zone_resource_group_name = "ploceusrg000001"                                          #(Required) Specifies the resource group name of Private DNS Zones to include within the private_dns_zone_group.This will be fetched by the data resource of private_dns_zone resource group name.
    # }
    private_endpoint_private_service_connection = {                        #(Required) A private_service_connection block as defined below.
      private_service_connection_name                 = "servicecon000001" #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
      private_service_connection_is_manual_connection = false              #(Required) set true if resource_alias != null
      private_connection_resource_name                = "ploceuskv000001"  #(Optional) The Service Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_resource_group_name = "ploceusrg000001"  #(Optional) The Service Resource Group Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      private_connection_resource_alias               = null               #(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified.
      request_message                                 = null               #(Optional) Should be enabled if the is_manual_connection is set as true.  A message passed to the owner of the remote resource
      subresource_names                               = ["vault"]          # (Optional) A list of subresource names which the Private Endpoint is able to connect to.
    }
    private_endpoint_ip_configuration = { # (Optional) One or more ip_configuration blocks as defined below. This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet.
      "ip_connfig_1" = {
        ip_configuration_name               = "ploceusipconfigurtaion000001" #(Required) Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
        ip_configuration_private_ip_address = "10.0.6.11"                    #(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
        ip_configuration_subresource_name   = "vault"                        #(Optional) A list of subresource names which the Private Endpoint is able to connect to.
        ip_configuration_member_name        = "default"                      #(Optional) Specifies the member name this IP address applies to. If it is not specified, it will use the value of subresource_name. Changing this forces a new resource to be created.
      }
    }
    private_endpoint_tags = { #(Optional)A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Landing Zone",
      Environment    = "PLZ-DC",
      Owner          = "Manish Kumar",
      Criticality    = "High",
      Classification = "Diamond",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}
