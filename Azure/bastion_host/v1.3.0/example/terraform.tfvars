#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
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
    virtual_network_location                = "eastus2"                   #(Required) The location/region where the virtual network is created.
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
    virtual_network_encryption = null #(Optional) A encryption block as defined below.
    virtual_network_subnet     = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {          #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#SUBNET
subnet_variables = {
  "subnet_1" = {
    subnet_name                                          = "AzureBastionSubnet"               # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                           = "ploceusrg000001"                  #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                              = ["10.0.1.0/26"]                    #(Required) The address prefixes to use for the subnet.
    subnet_virtual_network_name                          = "ploceusvnet000001"                #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_private_link_service_network_policies_enabled = null                               # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_private_endpoint_network_policies_enabled     = null                               # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true.
    subnet_service_endpoint_policy_ids                   = null                               #(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
    subnet_service_endpoints                             = ["Microsoft.AzureActiveDirectory"] #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation                                           = null
  }
}

#PUBLIC IP
public_ip_variables = {
  "public_ip_1" = {
    public_ip_name                                     = "ploceuspublicip000001"  # (Required) Specifies the name of the Public IP. 
    public_ip_resource_group_name                      = "ploceusrg000001"        # (Required) The name of the Resource Group where this Public IP should exist. 
    public_ip_location                                 = "eastus2"                # (Required) Specifies the supported Azure location where the Public IP should exist. 
    public_ip_ip_version                               = "IPv4"                   # (Optional) The IP Version to use, IPv6 or IPv4.
    public_ip_allocation_method                        = "Static"                 # (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic.
    public_ip_sku                                      = "Standard"               # (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic.
    public_ip_sku_tier                                 = "Regional"               # (Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional.
    public_ip_domain_name_label                        = "ploceuspublicip000001"  # (Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
    public_ip_prefix_id                                = null                     #  (Optional) If specified then public IP address allocated will be provided from the public IP prefix resource.
    public_ip_idle_timeout_in_minutes                  = "30"                     # (Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes.
    public_ip_zones                                    = ["1", "2", "3"]          # (Optional) A collection containing the availability zone to allocate the Public IP in.
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

#BASTION HOST
bastion_host_variables = {
  bastion_host_1 = {
    bastion_host_name                                = "ploceusbastionhost000001" #(Required) Specifies the name of the Bastion Host. Changing this forces a new resource to be created.
    bastion_host_resource_group_name                 = "ploceusrg000001"          #(Required) The name of the resource group in which to create the Bastion Host.
    bastion_host_location                            = "eastus2"                  #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. Review https://learn.microsoft.com/en-us/azure/bastion/bastion-faq for supported locations.
    bastion_host_is_copy_paste_enabled               = true                       #(Optional) Is Copy/Paste feature enabled for the Bastion Host. Defaults to true.
    bastion_host_is_file_copy_enabled                = false                      #(Optional) Is File Copy feature enabled for the Bastion Host. Defaults to false.
    bastion_host_sku                                 = "Basic"                    #(Optional) The SKU of the Bastion Host. Accepted values are Basic and Standard. Defaults to Basic.
    bastion_host_is_ip_connect_enabled               = false                      #(Optional) Is IP Connect feature enabled for the Bastion Host. Defaults to false.
    bastion_host_scale_units                         = 2                          #(Optional) The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50. Defaults to 2.
    bastion_host_is_shareable_link_enabled           = false                      #(Optional) Is Shareable Link feature enabled for the Bastion Host. Defaults to false.
    bastion_host_is_tunneling_enabled                = false                      #(Optional) Is Tunneling feature enabled for the Bastion Host. Defaults to false
    bastion_host_virtual_network_name                = "ploceusvnet000001"        #(Required) The Virtual network name for subnet ID
    bastion_host_virtual_network_resource_group_name = "ploceusrg000001"          #(Required) The Virtual network resource group name for subnet ID
    bastion_host_subnet_name                         = "AzureBastionSubnet"       #(Required) The Subnet name for Subnet ID
    bastion_host_public_ip_name                      = "ploceuspublicip000001"    #(Required) The Public IP name for public IP address ID
    bastion_host_public_ip_resource_group_name       = "ploceusrg000001"          #(Required) The Public IP resource group name for public IP address ID
    bastion_host_ip_configuration = {                                             #(Required) A ip_configuration block as defined below.
      ip_configuration_name = "ploceusipconfig000001"                             #(Required) The name of the IP configuration.
    }
    bastion_host_tags = { #(Optional) A mapping of tags to assign to the resource.
      Create_By   = "Ploceus"
      Departement = "CIS"
    }
  }
}