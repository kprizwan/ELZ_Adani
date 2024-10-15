
#RESOURCE GROUP SOURCE
resource_group_variables_source = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000002" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location   = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

# RESOURCE GROUP DESTINATION
resource_group_variables_destination = {
  "resource_group_2" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resouce Group with which it should be created.
    resource_group_location   = "eastus"          #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {                       #(Optional) A mapping of tags which should be assigned to the Resource Group.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL NETWORK SOURCE
virtual_network_variables_source = {
  "virtual_network_variables_source_1" = {
    virtual_network_name                    = "ploceusvnet000001"         #(Required) The name of the virtual network.
    virtual_network_location                = "eastus"                    #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000002"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.0.0/24"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) Provide virtual_network_ddos_protection_enable as true if needed ddos protection
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_encryption = [{
      virtual_network_encryption_enforcement = "AllowUnencrypted"
    }]
    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {      #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#VIRTUAL NETWORK DESTINATION
virtual_network_variables_destination = {
  "virtual_network_variables_destination_1" = {
    virtual_network_name                    = "ploceusvnet000002"         #(Required) The name of the virtual network.
    virtual_network_location                = "eastus"                    #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "ploceusrg000001"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.0.2.0/24"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = {                              #(Optional block) Provide virtual_network_ddos_protection_enable as true if needed ddos protection
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ploceusddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }
    virtual_network_encryption = [{
      virtual_network_encryption_enforcement = "AllowUnencrypted"
    }]
    virtual_network_subnet = null #(Optional) Can be specified multiple times to define multiple subnets
    virtual_network_tags = {      #(Optional) A mapping of tags which should be assigned to the virtual network.
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#DDOS plan creation is optional and costly. Uncommenting  will create a new DDOS protection plan. Use only if required. 
/* network_ddos_protection_plan_variables = {
  "ddos_plan_1" = {
    network_ddos_protection_plan_name                = "ploceusddosplan000001" #(Required) Specifies the name of the Network DDoS Protection Plan. 
    network_ddos_protection_plan_location            = "eastus"                #(Required) The name of the resource group in which to create the resource.
    network_ddos_protection_plan_resource_group_name = "ploceusrg000002"       #(Required) Specifies the supported Azure location where the resource exists.
    network_ddos_protection_plan_tags = {                                      #(Optional) A mapping of tags which should be assigned to the DDOS protection plan
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
} */

#SOURCE VIRTUAL NETWORK PEERING
source_virtual_network_peering_variables = {
  "source_virtual_network_peering_1" = {
    virtual_network_peering_name                             = "ploceusvnetpeering000001" # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = "ploceusrg000001"          # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = "ploceusvnet000002"        # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = "ploceusrg000002"          # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = "ploceusvnet000001"        # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = true                       # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = true                       # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = false                      #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = false                      # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = null                       # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }
}

#DESTINATION VIRTUAL NETWORK PEERING
destination_virtual_network_peering_variables = {
  "destination_virtual_network_peering_1" = {
    virtual_network_peering_name                             = "ploceusvnetpeering000003" # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = "ploceusrg000002"          # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = "ploceusvnet000001"        # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = "ploceusrg000001"          # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = "ploceusvnet000002"        # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = true                       # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = true                       # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = false                      #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = false                      # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = null                       # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }
}

source_subscription_id      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
source_tenant_id            = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
destination_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
destination_tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"