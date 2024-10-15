#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags = {                     #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#DDOS protection plan
network_ddos_protection_plan_variables = {
  "ddos_plan_1" = {
    network_ddos_protection_plan_name                = "ploceusddosplan000001" #(Required) Specifies the name of the Network DDoS Protection Plan. 
    network_ddos_protection_plan_location            = "westus2"               #(Required) The name of the resource group in which to create the resource.
    network_ddos_protection_plan_resource_group_name = "ploceusrg000001"       #(Required) Specifies the supported Azure location where the resource exists.
    network_ddos_protection_plan_tags = {                                      #(Optional) A mapping of tags which should be assigned to the DDOS protection plan
      Created_By = "Ploceus",
      Department = "CIS"
    }
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