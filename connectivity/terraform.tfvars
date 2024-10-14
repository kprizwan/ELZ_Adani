# Connectivity Subscription 

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-plz-connectivity-rg-01" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "Central India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
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

#VIRTUAL NETWORK 
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "sd-plz-Connectivity-Hub-VNET"         #(Required) The name of the virtual network.
    virtual_network_location                = "Central India"                    #(Required) The location/region where the virtual network is created.
    virtual_network_resource_group_name     = "sd-plz-connectivity-rg-01"           #(Required) The name of the resource group in which to create the virtual network.
    virtual_network_address_space           = ["10.248.6.0/24","10.248.7.0/24","10.248.8.0/24","10.248.9.0/24","10.248.10.0/24","10.248.11.0/24","10.248.12.0/24","10.248.13.0/24","10.248.14.0/24","10.248.15.0/24","10.248.16.0/24","10.248.17.0/24","10.248.18.0/24"]             #(Required) The address space that is used the virtual network.
    virtual_network_dns_servers             = null                        #(Optional) List of IP addresses of DNS servers.Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
    virtual_network_flow_timeout_in_minutes = null                        #(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes.
    virtual_network_bgp_community           = null                        #(Optional) The BGP community attribute in format <as-number>:<community-value>.The as-number segment is the Microsoft ASN, which is always 12076 for now.
    virtual_network_edge_zone               = null                        #(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created.
    virtual_network_ddos_protection_plan = null /*{                              #(Optional block) provide true for virtual_network_ddos_protection_enable incase ddos_protection needs to be enabled.
      virtual_network_ddos_protection_enable    = false                   #(Required) Enable/disable DDoS Protection Plan on Virtual Network.
      virtual_network_ddos_protection_plan_name = "ddosplan000001" #(Required) Needed for ddos protection plan id.Provide the name of the ddos protection plan if above enable is true
    }*/
    virtual_network_encryption = [
      {
        virtual_network_encryption_enforcement = "AllowUnencrypted"
      }
    ]
    virtual_network_subnet = [ #(Optional) Can be specified multiple times to define multiple subnets
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-NAT-SNET-01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.6.0/26"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null    #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null     #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-FW-Mgmt-SNET-01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.7.128/27"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "	10.248.7.0/26"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-FW-UnTrust-SNET-02" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.7.64/26"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.8.0/26"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-FW-Trust-SNET-02" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.8.64/26"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-FW-Intranet-LB-SNET-01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.9.0/27"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-AGW-SNET-01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.10.0/24"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "GatewaySubnet" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.11.0/26"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      },
      {
        virtual_network_subnet_name                                       = "sd-plz-Connectivity-Hub-VNET-APIM-SNET-01" #(Optional) Can be specified multiple times to define multiple subnets
        virtual_network_subnet_address_prefix                             = "10.248.12.0/24"         #(Required) The address prefix to use for the subnet.
        virtual_network_subnet_network_security_group_name                = null                  #(Optional) The Network Security Group to associate with the subnet.
        virtual_network_subnet_network_security_group_resource_group_name = null                  #(Optional) The Network Security Group to associate with the subnet.
      }
    ]
    virtual_network_tags = { #(Optional) A mapping of tags which should be assigned to the virtual network.
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
