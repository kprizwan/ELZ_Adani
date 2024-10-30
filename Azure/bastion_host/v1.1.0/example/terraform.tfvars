# Resource Group
resource_group_variables = {
  "resource_group_01" = {
    location = "eastus"
    name     = "ploceusrg000001"
    resource_group_tags = {
      "Created_By" = "Pratik"
      "Departemnt" = "CIS"
    }
  }
}

# Virtual network
vnets_variables = {
  "vnet_1" = {
    name                        = "ploceusvnet000001a"
    location                    = "eastus"
    resource_group_name         = "ploceusrg000001"
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

# Subnet
subnet_variables = {
  "subnet_1" = {
    name                                           = "AzureBastionSubnet" # The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26.
    resource_group_name                            = "ploceusrg000001"
    address_prefixes                               = ["10.0.2.0/26"]
    virtual_network_name                           = "ploceusvnet000001a"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = false #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  }
}

# Public IP
public_ip_variables = {
  "public_ip_1" = {
    name                    = "ploceuspublicip000001a"
    resource_group_name     = "ploceusrg000001"
    location                = "eastus"
    ip_version              = "IPv4"
    allocation_method       = "Static"
    sku                     = "Standard"
    sku_tier                = "Regional"
    public_ip_dns           = "ploceuspublicip000002a"
    public_ip_prefix_id     = null
    idle_timeout_in_minutes = "30"
    zones                   = ["1", "3"]
    edge_zone               = null
    reverse_fqdn            = null
    ip_tags                 = null
    public_ip_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

# AZURE BASTION HOST VARIABLES
azure_bastion_host_variables = {
  bastion_host_01 = {
    bastion_host_virtual_network_name                = "ploceusvnet000001a"
    bastion_host_virtual_network_resource_group_name = "ploceusrg000001"
    bastion_host_subnet_name                         = "AzureBastionSubnet" # The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26.
    bastion_host_subnet_resource_group_name          = "ploceusrg000001"
    bastion_host_public_ip_name                      = "ploceuspublicip000001a"
    bastion_host_public_ip_resource_group_name       = "ploceusrg000001"
    bastion_host_name                                = "ploceusbastionhost000001" # Specifies the name of the Bastion Host
    bastion_host_location                            = "eastus"                   # Specifies the supported Azure location where the resource exists.
    bastion_host_resource_group_name                 = "ploceusrg000001"          # The name of the resource group in which to create the Bastion Host.
    bastion_host_copy_paste_enabled                  = true                       # is Copy/Paste feature enabled for the Bastion Host. Defaults to true.
    bastion_host_file_copy_enabled                   = false                      # Is File Copy feature enabled for the Bastion Host. Defaults to false.
    bastion_host_sku                                 = "Basic"                    # Accepted values are Basic and Standard. Defaults to Basic.
    bastion_host_ip_connect_enabled                  = false                      # Is IP Connect feature enabled for the Bastion Host. Defaults to false.
    bastion_host_scale_units                         = 2                          # scale_units can only be changed when sku is Standard. scale_units is always 2 when sku is Basic.Possible values are between 2 and 50
    bastion_host_shareable_link_enabled              = false                      # Is Shareable Link feature enabled for the Bastion Host. Defaults to false.
    bastion_host_tunneling_enabled                   = false                      # Is Tunneling feature enabled for the Bastion Host. Defaults to false.
    bastion_host_ip_configuration = {
      ip_configuration_name = "ploceusipconfig000001" # The name of the IP configuration.
    }

    bastion_host_tags = {
      Create_By   = "Ploceus"
      Departement = "CIS"
    }
  }
}