############## Connectivity Subscription Resources #####################################

#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name       = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = string      #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags       = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
  description = "Map of Resource groups"
  default = {
  }
}
#VIRTUAL NETWORK VARIABLE
variable "virtual_network_variables" {
  description = "Map of vnet objects. name, vnet_address_space, and dns_server supported"
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
  default = {}
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
  description = "Map of Subnet variables"
  default     = {}
}

#NETWORK INTERFACE VARIABLES
variable "network_interface_variables" {
  description = "Map of Network interface"
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
  default = {}
}

#APPLICATION GATEWAY VARIABLES
variable "application_gateway_variables" {
  description = "Map of application gateway variables"
  type = map(object({
    application_gateway_name                              = string       #(Required) The name of the Application Gateway. Changing this forces a new resource to be created.                             
    application_gateway_resource_group_name               = string       #(Required) The name of the resource group in which to the Application Gateway should exist. Changing this forces a new resource to be created.                 
    application_gateway_location                          = string       #(Required) The Azure region where the Application Gateway should exist. Changing this forces a new resource to be created.                 
    application_gateway_sku_capacity                      = number       #(Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set.                 
    application_gateway_vnet_name                         = string       #Name of the virtual network to be associated with Application Gateway               
    application_gateway_vnet_resource_group_name          = string       #name of the virtual network resource group name
    application_gateway_subnet_name                       = string       #Name of the subnet to be associated with Application Gateway                 
    application_gateway_frontend_port                     = number       #(Required) The port used for this Frontend Port.                 
    application_gateway_is_private_frontend_ip_required   = bool         #(Optional) The Private IP Address to use for the Application Gateway.              
    application_gateway_is_public_frontend_ip_required    = bool         #(Optional) The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the Azure documentation for public IP addresses for details.                 
    application_gateway_is_waf_policy_required            = bool         #(Optional) A waf_configuration block                 
    application_gateway_waf_policy_name                   = string       #Name of the waf Policy                  
    application_gateway_waf_policy_resource_group_name    = string       #Resource Group of the waf policy                
    application_gateway_public_ip_name                    = string       #(Optional) The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the Azure documentation for public IP addresses for details.               
    application_gateway_fips_enabled                      = bool         #(Optional) Is FIPS enabled on the Application Gateway?               
    application_gateway_force_firewall_policy_association = bool         #(Optional) Is the Firewall Policy associated with the Application Gateway?               
    application_gateway_zones                             = list(string) #(Optional) Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created.                   

    application_gateway_keyvault_cert_configuration = object({             #Key Vault cert configuration      
      keyvault_cert_configuration_certificate_keyvault_name       = string #Name of the key vault certificate configuration                   
      keyvault_cert_configuration_certificate_resource_group_name = string #Resource Group Name of the key vault certificate configuration                    
    })

    application_gateway_application_gateway_tags = map(string) #(Optional) A mapping of tags to assign to the resource.
    application_gateway_enable_http2             = bool        #(Optional) Is HTTP2 enabled on the application gateway resource? Defaults to false.

    application_gateway_sku = object({ #(Required) A sku block as defined below.
      sku_name     = string            #(Required) The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2.
      sku_tier     = string            #(Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2.
      sku_capacity = number            #(Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set.
    })

    application_gateway_trusted_client_certificate = list(object({                       #
      trusted_client_certificate_name                                           = string #(Required) The name of the Trusted Client Certificate that is unique within this Application Gateway.
      trusted_client_certificate_trusted_client_certificate_resource_group_name = string #Resource group of the trusted client certificate
    }))

    application_gateway_ssl_certificate = list(object({           #A list of ssl_certificate blocks as defined below.
      ssl_certificate_name                               = string #Name of the ssl certificate name
      ssl_certificate_key_vault_secret_name              = string #Key vault name of the ssl certificate
      ssl_certificate_data                               = string #(Optional) The base64-encoded PFX certificate data. Required if key_vault_secret_id is not set.
      ssl_certificate_pfx_password_key_vault_secret_name = string #(Optional) Password for the pfx file specified in data. Required if data is set.
    }))

    application_gateway_authentication_certificate = list(object({ # (Optional) One or more authentication_certificate blocks as defined below.
      authentication_certificate_name                  = string    #(Required) The Name of the Authentication Certificate to use.
      authentication_certificate_key_vault_secret_name = string    #Authentication Certificate key vault secret name
    }))

    application_gateway_trusted_root_certificate = list(object({ #A trusted_root_certificate block supports the following:
      trusted_root_certificate_name                  = string    #(Required) The Name of the Trusted Root Certificate to use.
      trusted_root_certificate_key_vault_secret_name = string    #Trusted root certificate key vault secret name  
      trusted_root_certificate_data                  = string    #(Optional) The contents of the Trusted Root Certificate which should be used. Required if key_vault_secret_id is not set.
    }))

    application_gateway_identity = list(object({     #An identity block supports the following:
      identity_type                         = string #(Required) Specifies the type of Managed Service Identity that should be configured on this Application Gateway. Only possible value is UserAssigned.  
      identity_identity_name                = string #Name of the identity
      identity_identity_resource_group_name = string #Resource group of identity
    }))

    application_gateway_private_link_configuration = list(object({ #A private_link_configuration block supports the following:
      private_link_configuration_name = string                     #name - (Required) The name of the private link configuration.
      private_link_configuration_ip_configuration = list(object({  #(Required) One or more ip_configuration blocks as defined below.
        ip_configuration_subnet_id                     = string    #subnet id of ip configuration
        ip_configuration_private_ip_address_allocation = string    #ip configuration 
        ip_configuration_name                          = bool      #(Optional) The Allocation Method for the Private IP Address. Possible values are Dynamic and Static
        ip_configuration_private_ip_address            = string    #(Optional) The Static IP Address which should be used.
        ip_configuration_primary                       = bool      #Primary ip configuration
      }))
    }))

    application_gateway_ssl_profile = list(object({             #(Optional) One or more ssl_profile blocks as defined below.
      ssl_profile_name                                 = string #(Optional) The name of the associated SSL Profile which should be used for this HTTP Listener.
      ssl_profile_trusted_client_certificate_names     = string #(Required) The name of the Trusted Client Certificate that is unique within this Application Gateway.
      ssl_profile_verify_client_cert_issuer_dn         = string #(Required) The base-64 encoded certificate.
      ssl_profile_verify_client_certificate_revocation = string #(Optional) Specify the method to check client certificate revocation status. Possible value is OCSP.
    }))

    application_gateway_ssl_policy = list(object({   #A ssl_profile block supports the following:
      ssl_policy_name                 = string       #(Required) The name of the SSL Profile that is unique within this Application Gateway.
      ssl_policy_policy_type          = string       #(Optional) The Type of the Policy. Possible values are Predefined and Custom.
      ssl_policy_cipher_suites        = list(string) #(Optional) A List of accepted cipher suites. Possible values are: TLS_DHE_DSS_WITH_AES_128_CBC_SHA, TLS_DHE_DSS_WITH_AES_128_CBC_SHA256, TLS_DHE_DSS_WITH_AES_256_CBC_SHA, TLS_DHE_DSS_WITH_AES_256_CBC_SHA256, TLS_DHE_RSA_WITH_AES_128_CBC_SHA, TLS_DHE_RSA_WITH_AES_128_GCM_SHA256, TLS_DHE_RSA_WITH_AES_256_CBC_SHA, TLS_DHE_RSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256, TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384, TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384, TLS_RSA_WITH_3DES_EDE_CBC_SHA, TLS_RSA_WITH_AES_128_CBC_SHA, TLS_RSA_WITH_AES_128_CBC_SHA256, TLS_RSA_WITH_AES_128_GCM_SHA256, TLS_RSA_WITH_AES_256_CBC_SHA, TLS_RSA_WITH_AES_256_CBC_SHA256 and TLS_RSA_WITH_AES_256_GCM_SHA384.
      ssl_policy_min_protocol_version = string       #(Optional) The minimal TLS version. Possible values are TLSv1_0, TLSv1_1 and TLSv1_2.
      ssl_policy_disabled_protocols   = list(string) #(Optional) A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3.
    }))

    application_gateway_autoscale_configuration = object({ #A autoscale_configuration block supports the following:
      autoscale_configuration_min_capacity = number        #(Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
      autoscale_configuration_max_capacity = number        #(Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
    })

    application_gateway_frontend_ports = list(object({ #A frontend_port block supports the following:
      frontend_ports_name = string                     #(Required) The name of the Frontend Port.
      frontend_ports_port = number                     #(Required) The port used for this Frontend Port.
    }))

    application_gateway_backend_address_pools = list(object({ #A backend_address_pool block supports the following:
      backend_address_pools_name         = string             #(Required) The name of the Backend Address Pool.
      backend_address_pools_fqdns        = list(string)       #(Optional) A list of FQDN's which should be part of the Backend Address Pool.
      backend_address_pools_ip_addresses = list(string)       #(Optional) A list of IP Addresses which should be part of the Backend Address Pool.
    }))

    application_gateway_backend_http_settings = list(object({                  #A backend_http_settings block supports the following: 
      backend_http_settings_name                                = string       #(Required) The name of the Backend HTTP Settings Collection.
      backend_http_settings_cookie_based_affinity               = string       #(Required) Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled.
      backend_http_settings_path                                = string       #(Optional) The Path which should be used as a prefix for all HTTP requests.
      backend_http_settings_port                                = number       #(Required) The port which should be used for this Backend HTTP Settings Collection.
      backend_http_settings_request_timeout                     = number       #(Required) The request timeout in seconds, which must be between 1 and 86400 seconds.
      backend_http_settings_probe_name                          = string       #(Optional) The name of an associated HTTP Probe.
      backend_http_settings_protocol                            = string       #(Optional) The name of an associated HTTP Probe.
      backend_http_settings_host_name                           = string       #(Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true.
      backend_http_settings_pick_host_name_from_backend_address = bool         #(Optional) Whether host header should be picked from the host name of the backend server. Defaults to false.
      backend_http_settings_affinity_cookie_name                = string       #(Optional) The name of the affinity cookie.
      backend_http_settings_trusted_root_certificate_names      = list(string) #(Optional) A list of trusted_root_certificate names.
      backend_http_settings_authentication_certificate = list(object({         #A authentication_certificate block supports the following:
        authentication_certificate_name = string                               #(Required) The Name of the Authentication Certificate to use.
      }))
      backend_http_settings_connection_draining = list(object({ #A connection_draining block supports the following:
        connection_draining_enabled           = bool            #(Required) If connection draining is enabled or not.
        connection_draining_drain_timeout_sec = string          #(Required) The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds.
      }))
    }))

    application_gateway_gateway_ip_configuration = list(object({ #A frontend_ip_configuration block supports the following: 
      gateway_ip_configuration_name        = string              #(Required) The name of the Frontend IP Configuration.
      gateway_ip_configuration_subnet_name = string              #(Required) The Name of the Subnet which the Application Gateway should be connected to.
    }))

    application_gateway_frontend_ip_configuration = list(object({        #A frontend_ip_configuration block supports the following:
      frontend_ip_configuration_name                            = string #(Required) The name of the Frontend IP Configuration.
      frontend_ip_configuration_private_ip_address              = string #(Optional) The Private IP Address to use for the Application Gateway.
      frontend_ip_configuration_private_ip_address_allocation   = string #(Optional) The Allocation Method for the Private IP Address. Possible values are Dynamic and Static.
      frontend_ip_configuration_private_link_configuration_name = string #(Optional) The name of the private link configuration to use for this frontend IP configuration.
      frontend_ip_configuration_is_private_frontend_ip_required = bool   #if private frontend ip is required or not.
      frontend_ip_configuration_is_public_frontend_ip_required  = bool   #if public frontend ip is required or not.
    }))

    application_gateway_http_listener = list(object({             #A http_listener block supports the following:
      http_listener_name                           = string       #(Required) The Name of the HTTP Listener.
      http_listener_frontend_ip_configuration_name = string       #(Required) The Name of the Frontend IP Configuration used for this HTTP Listener.
      http_listener_frontend_port_name             = string       #(Required) The Name of the Frontend Port use for this HTTP Listener.
      http_listener_ssl_certificate_name           = string       #(Optional) The name of the associated SSL Certificate which should be used for this HTTP Listener.
      http_listener_protocol                       = string       #(Required) The Protocol to use for this HTTP Listener. Possible values are Http and Https.
      http_listener_sni_required                   = bool         #(Optional) Should Server Name Indication be Required? Defaults to false.
      http_listener_listener_type                  = string       # MultiSite or Basic
      http_listener_host_name                      = string       # Required if listener_type = MultiSite and host_names = null
      http_listener_host_names                     = list(string) # Required if listener_type = MultiSite and host_name = null
      http_listener_ssl_profile_name               = string       #(Optional) The name of the associated SSL Profile which should be used for this HTTP Listener.
      http_listener_custom_error_configuration = list(object({    #(Optional) One or more custom_error_configuration blocks as defined below.
        custom_error_configuration_status_code           = string #(Required) Status code of the application gateway customer error. Possible values are HttpStatus403 and HttpStatus502
        custom_error_configuration_custom_error_page_url = string #(Required) Error page URL of the application gateway customer error.
      }))
    }))

    application_gateway_request_routing_rules = list(object({    #A request_routing_rule block exports the following:`
      request_routing_rules_name                        = string #(Required) The Name of this Request Routing Rule.
      request_routing_rules_rule_type                   = string #(Required) The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting.
      request_routing_rules_listener_name               = string #(Required) The Name of the HTTP Listener which should be used for this Routing Rule.
      request_routing_rules_backend_address_pool_name   = string #(Optional) The Name of the Backend Address Pool which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.
      request_routing_rules_backend_http_settings_name  = string #(Optional) The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.
      request_routing_rules_redirect_configuration_name = string #(Optional) The Name of the Redirect Configuration which should be used for this Routing Rule. Cannot be set if either backend_address_pool_name or backend_http_settings_name is set.
      request_routing_rules_url_path_map_name           = string #(Optional) The Name of the URL Path Map which should be associated with this Routing Rule.
      request_routing_rules_priority                    = string #(Optional) Rule evaluation order can be dictated by specifying an integer value from 1 to 20000 with 1 being the highest priority and 20000 being the lowest priority.
      request_routing_rules_rewrite_rule_set_name       = string #(Optional) The Name of the Rewrite Rule Set which should be used for this Routing Rule. Only valid for v2 SKUs.
    }))

    application_gateway_global = object({      #(Optional) A global block as defined below.
      global_request_buffering_enabled  = bool #(Required) Whether Application Gateway's Request buffer is enabled.
      global_response_buffering_enabled = bool #(Required) Whether Application Gateway's Response buffer is enabled.
    })

    application_gateway_url_path_maps = list(object({            #A url_path_map block supports the following:
      url_path_maps_name                                = string #(Required) The Name of the URL Path Map.
      url_path_maps_default_backend_http_settings_name  = string #(Optional) The Name of the Default Backend Address Pool which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
      url_path_maps_default_backend_address_pool_name   = string #(Optional) The Name of the Default Backend HTTP Settings Collection which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set.
      url_path_maps_default_redirect_configuration_name = string #(Optional) The Name of the Default Redirect Configuration which should be used for this URL Path Map. Cannot be set if either default_backend_address_pool_name or default_backend_http_settings_name is set.
      url_path_maps_default_rewrite_rule_set_name       = string #(Optional) The Name of the Default Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
      url_path_maps_path_rules = list(object({                   #(Required) One or more path_rule blocks as defined above.
        path_rules_name                        = string          #(Required) The Name of the Path Rule.
        path_rules_paths                       = list(string)    #(Required) A list of Paths used in this Path Rule.
        path_rules_backend_http_settings_name  = string          #(Optional) The Name of the Backend HTTP Settings Collection to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
        path_rules_backend_address_pool_name   = string          #(Optional) The Name of the Backend Address Pool to use for this Path Rule. Cannot be set if redirect_configuration_name is set.
        path_rules_redirect_configuration_name = string          #(Optional) The Name of a Redirect Configuration to use for this Path Rule. Cannot be set if backend_address_pool_name or backend_http_settings_name is set.
        path_rules_rewrite_rule_set_name       = string          #(Optional) The Name of the Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.
      }))
    }))

    application_gateway_waf_configuration = object({      #A waf_configuration block supports the following:
      waf_configuration_firewall_mode            = string #(Required) The Web Application Firewall Mode. Possible values are Detection and Prevention.
      waf_configuration_rule_set_type            = string #(Required) The Type of the Rule Set used for this Web Application Firewall. Currently, only OWASP is supported.
      waf_configuration_rule_set_version         = number #(Required) The Version of the Rule Set used for this Web Application Firewall. Possible values are 2.2.9, 3.0, 3.1, and 3.2.
      waf_configuration_enabled                  = bool   #(Required) Is the Web Application Firewall enabled?
      waf_configuration_file_upload_limit_mb     = string #(Optional) The File Upload Limit in MB. Accepted values are in the range 1MB to 750MB for the WAF_v2 SKU, and 1MB to 500MB for all other SKUs. Defaults to 100MB.
      waf_configuration_request_body_check       = bool   #(Optional) Is Request Body Inspection enabled? Defaults to true
      waf_configuration_max_request_body_size_kb = string #(Optional) The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB. Defaults to 128KB.

      waf_configuration_disabled_rule_group = object({     #A disabled_rule_group block supports the following:
        disabled_rule_group_rule_group_name = string       #(Required) The rule group where specific rules should be disabled. Accepted values are: crs_20_protocol_violations, crs_21_protocol_anomalies, crs_23_request_limits, crs_30_http_policy, crs_35_bad_robots, crs_40_generic_attacks, crs_41_sql_injection_attacks, crs_41_xss_attacks, crs_42_tight_security, crs_45_trojans, General, REQUEST-911-METHOD-ENFORCEMENT, REQUEST-913-SCANNER-DETECTION, REQUEST-920-PROTOCOL-ENFORCEMENT, REQUEST-921-PROTOCOL-ATTACK, REQUEST-930-APPLICATION-ATTACK-LFI, REQUEST-931-APPLICATION-ATTACK-RFI, REQUEST-932-APPLICATION-ATTACK-RCE, REQUEST-933-APPLICATION-ATTACK-PHP, REQUEST-941-APPLICATION-ATTACK-XSS, REQUEST-942-APPLICATION-ATTACK-SQLI, REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION
        disabled_rule_group_rules           = list(string) #(Optional) A list of rules which should be disabled in that group. Disables all rules in the specified group if rules is not specified.
      })

      waf_configuration_exclusion = object({       #A exclusion block supports the following:
        exclusion_match_variable          = string #(Required) Match variable of the exclusion rule to exclude header, cookie or GET arguments. Possible values are RequestArgKeys, RequestArgNames, RequestArgValues, RequestCookieKeys, RequestCookieNames, RequestCookieValues, RequestHeaderKeys, RequestHeaderNames and RequestHeaderValues
        exclusion_selector_match_operator = string #(Optional) Operator which will be used to search in the variable content. Possible values are Contains, EndsWith, Equals, EqualsAny and StartsWith. If empty will exclude all traffic on this match_variable
        exclusion_selector                = string #(Optional) String value which will be used for the filter operation. If empty will exclude all traffic on this match_variable
      })
    })

    application_gateway_probe = list(object({                  #A probe block support the following:
      probe_name                                      = string #(Required) The Name of the Probe.  
      probe_path                                      = string #(Required) The Path used for this Probe.
      probe_interval                                  = number #(Required) The Interval between two consecutive probes in seconds. Possible values range from 1 second to a maximum of 86,400 seconds.
      probe_protocol                                  = string #(Required) The Protocol used for this Probe. Possible values are Http and Https.
      probe_timeout                                   = number #(Required) The Timeout used for this Probe, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86,400 seconds.
      probe_unhealthy_threshold                       = number #(Required) The Unhealthy Threshold for this Probe, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 to 20.
      probe_host                                      = string #(Optional) The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true.
      probe_port                                      = string #(Optional) Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from HTTP settings will be used. This property is valid for Standard_v2 and WAF_v2 only.
      probe_minimum_servers                           = string #(Optional) The minimum number of servers that are always marked as healthy. Defaults to 0.
      probe_pick_host_name_from_backend_http_settings = bool   #(Optional) Whether the host header should be picked from the backend HTTP settings. Defaults to false.
      probe_match = list(object({                              #(Optional) A match block as defined above.
        match_body        = string                             #A snippet from the Response Body which must be present in the Response.
        match_status_code = list(string)                       #(Required) A list of allowed status codes for this Health Probe.
      }))
    }))

    application_gateway_redirect_configurations = list(object({ #A redirect_configuration block supports the following:
      redirect_configurations_name                 = string     #(Required) Unique name of the redirect configuration block
      redirect_configurations_redirect_type        = string     #(Required) The type of redirect. Possible values are Permanent, Temporary, Found and SeeOther
      redirect_configurations_target_listener_name = string     #(Optional) The name of the listener to redirect to. Cannot be set if target_url is set.
      redirect_configurations_target_url           = string     #(Optional) The Url to redirect the request to. Cannot be set if target_listener_name is set.
      redirect_configurations_include_path         = bool       #(Optional) Whether or not to include the path in the redirected Url. Defaults to false
      redirect_configurations_include_query_string = bool       #(Optional) Whether or not to include the query string in the redirected Url. Default to false
    }))

    application_gateway_rewrite_rule_set = list(object({ #A rewrite_rule_set block supports the following:
      rewrite_rule_set_name = string                     #(Required) Unique name of the rewrite rule set block
      rewrite_rule_set_rewrite_rule = list(object({      #block supports the following:
        rewrite_rule_name          = string              #(Required) Unique name of the rewrite rule block
        rewrite_rule_rule_sequence = string              #(Required) Rule sequence of the rewrite rule that determines the order of execution in a set.
        rule_sequence_condition = list(object({          #(Optional) One or more condition blocks as defined above.
          condition_variable    = string                 #(Required) The variable of the condition.
          condition_pattern     = string                 #(Required) The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition.
          condition_ignore_case = string                 #(Optional) Perform a case in-sensitive comparison. Defaults to false
          condition_negate      = string                 #(Optional) Negate the result of the condition evaluation. Defaults to false
        }))
        rewrite_rule_set_response_header_configuration = list(object({ #A response_header_configuration block supports the following:
          response_header_configuration_header_name  = string          #(Required) Header name of the header configuration.
          response_header_configuration_header_value = string          #(Required) Header value of the header configuration. To delete a response header set this property to an empty string.
        }))
        rewrite_rule_set_request_header_configuration = list(object({ #A request_header_configuration block supports the following:
          request_header_configuration_header_name  = string          #(Required) Header name of the header configuration.
          request_header_configuration_header_value = string          #(Required) Header value of the header configuration. To delete a request header set this property to an empty string.
        }))
        rewrite_rule_set_url = list(object({ #A url block supports the following:
          url_path         = string          #(Optional) The URL path to rewrite.
          url_query_string = string          #(Optional) The query string to rewrite.
          url_reroute      = string          #(Optional) Whether the URL path map should be reevaluated after this rewrite has been applied. More info on rewrite configutation
          url_components   = string          #(Optional) The components used to rewrite the URL. Possible values are path_only and query_string_only to limit the rewrite to the URL Path or URL Query String only.
        }))
      }))
    }))

  }))
  default = {}
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

#VIRTUAL NETWORK PEEING VARIABLES
variable "source_virtual_network_peering_variables" {
  type = map(object({
    virtual_network_peering_name                             = string      # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = string      # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = string      # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = string      # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = string      # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = bool        # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = bool        # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = bool        #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = bool        # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = map(string) # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }))
  description = "Map of object of virtual network peering_variables"
  default     = {}
}

#VIRTUAL NETWORK PEEING VARIABLES
variable "destination_virtual_network_peering_variables" {
  type = map(object({
    virtual_network_peering_name                             = string      # (Required) The name of the source virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_resource_group_name  = string      # (Required) The name of the destination virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_destination_virtual_network_name = string      # (Required) The name of the destination virtual network name.
    virtual_network_peering_resource_group_name              = string      # (Required) The name of the source virtual network resource group and in which to create the virtual network peering. Changing this forces a new resource to be created.
    virtual_network_peering_virtual_network_name             = string      # (Required) The name of the source virtual network name.
    virtual_network_peering_allow_virtual_network_access     = bool        # (Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true.
    virtual_network_peering_allow_forwarded_traffic          = bool        # (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false.
    virtual_network_peering_use_remote_gateways              = bool        #  (Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false.
    virtual_network_peering_allow_gateway_transit            = bool        # (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    virtual_network_peering_triggers                         = map(string) # (Optional) A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network. See the trigger example for an example on how to set it up.
  }))
  description = "Map of object of virtual network peering_variables"
  default     = {}
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

#VPN GATEWAY VARIABLES
variable "vpn_gateway_variables" {
  type = map(object({
    vpn_gateway_name                                  = string #(Required) The Name which should be used for this VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_location                              = string #(Required) The Azure location where this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_resource_group_name                   = string #(Required) The Name of the Resource Group in which this VPN Gateway should be created. Changing this forces a new resource to be created.
    vpn_gateway_virtual_hub_name                      = string # The Name of the virtual hub
    vpn_gateway_bgp_route_translation_for_nat_enabled = bool   #(Optional) Is BGP route translation for NAT on this VPN Gateway enabled? Defaults to false
    vpn_gateway_bgp_settings_enabled                  = bool   #(Optional) A bgp_settings block as defined below.
    vpn_gateway_bgp_settings = object({
      vpn_gateway_bgp_settings_asn                                       = number       #(Required) The ASN of the BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_peer_weight                               = number       #(Required) The weight added to Routes learned from this BGP Speaker. Changing this forces a new resource to be created.
      vpn_gateway_bgp_settings_instance_0_bgp_peering_address_custom_ips = list(string) #(Optional) An instance_bgp_peering_address block as defined below.
      vpn_gateway_bgp_settings_instance_1_bgp_peering_address_custom_ips = list(string) #(Optional) An instance_bgp_peering_address block as defined below.
    })
    vpn_gateway_routing_preference = string      #(Optional) Azure routing preference lets you to choose how your traffic routes between Azure and the internet. You can choose to route traffic either via the Microsoft network (default value, Microsoft Network), or via the ISP network (public internet, set to Internet). More context of the configuration can be found in the Microsoft Docs to create a VPN Gateway. Changing this forces a new resource to be created.
    vpn_gateway_scale_unit         = number      #(Optional) The Scale Unit for this VPN Gateway. Defaults to 1.
    vpn_gateway_tags               = map(string) #(Optional) A mapping of tags to assign to the VPN Gateway.
  }))
  description = "Map of VPN Gateway object"
  default     = {}
}

#NAT GATEWAY VARIABLES
variable "nat_gateway_variables" {
  type = map(object({
    nat_gateway_name                    = string       #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_location                = string       #(Optional) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name     = string       #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist. Changing this forces a new resource to be created.
    nat_gateway_sku_name                = string       #(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. 
    nat_gateway_idle_timeout_in_minutes = string       #(Optional) The idle timeout which should be used in minutes. Defaults to 4.
    nat_gateway_zones                   = list(string) #(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created.
    nat_gateway_tags                    = map(string)  #(Optional) A mapping of tags to assign to the resource. Changing this forces a new resource to be created.
  }))
  default     = {}
  description = "Map of object of nat gateway variables"
}

#NAT GATEWAY PUBLIC IP ASSOCIATION VARIABLES
variable "nat_gateway_public_ip_association_variables" {
  description = "Map of object of nat gateway public ip associations"
  type = map(object({
    public_ip_name                  = string #(Required) Specifies the name of the Public IP.
    public_ip_resource_group_name   = string #(Required) The name of the Resource Group where this Public IP should exist.
    nat_gateway_name                = string #(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.
    nat_gateway_resource_group_name = string #(Required) Specifies the name of the Resource Group in which the NAT Gateway should exist.
  }))
  default = {}
}

# NETWORK SECURITY GROUP VARIABLES
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

# Network security group association variable
variable "network_security_group_association_variables" {
  type = map(object({
    network_interface_security_group_association = list(object({                             # (Optional) The block for security group association with network interface
      network_security_group_association_network_interface_name                     = string # (Required) The name of the network interface
      network_security_group_association_network_security_group_name                = string # (Required) The name of the network security group name to associate with network interface
      network_security_group_association_network_interface_resource_group_name      = string # (Required) The resource group name which contains network interface
      network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name which contains security group
    }))
    subnet_security_group_association = list(object({                                        # (Optional) The block for security group association with subnet
      network_security_group_association_virtual_network_name                       = string # (Required) The name of the virtual network where subnets are created
      network_security_group_association_subnet_name                                = string # (Required) The name subnet which needs to be associated with network security group
      network_security_group_association_network_security_group_name                = string # (Required)  The name of network_security_group_name to assiciate with subnet
      network_security_group_association_virtual_network_resource_group_name        = string # (Required) The resource group name of the virtual network
      network_security_group_association_network_security_group_resource_group_name = string # (Required) The resource group name of security group.
    }))
  }))
  description = "Map of object network security group association variables"
  default     = {}
}
#ROUTE TABLE VARIABLES
variable "route_table_variables" {
  description = "Map of Route Table object"
  type = map(object({
    route_table_name                          = string      #(Required) The name of the route table. 
    route_table_location                      = string      #(Required) The Azure location where the resource should exist.
    route_table_resource_group_name           = string      #(Required) The name of the resource group in which to create the route table.
    route_table_disable_bgp_route_propagation = bool        #(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. Default value "false"
    route_table_tags                          = map(string) #(Optional) A mapping of tags to assign to the resource.
    route_table_route = list(object({                       #(Optional) List of objects representing routes.
      route_name                   = string                 #(Required) The name of the route.
      route_address_prefix         = string                 #(Required) The destination to which the route applies. Can be CIDR(such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format.
      route_next_hop_type          = string                 #(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
      route_next_hop_in_ip_address = string                 #(Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance. Default value "null"
    }))
  }))
  default = {}
}