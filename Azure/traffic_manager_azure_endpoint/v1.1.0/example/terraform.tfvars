#RESOURCE GROUP 
resource_group_variables = {
  "resource_group_1" = {
    name     = "ploceusrg00000102"
    location = "eastus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#RESOURCE GROUP for public ip
resource_group_public_ip_variables = {
  "resource_group_2" = {
    name     = "ploceusrg00000103"
    location = "eastus2"
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}
#TRAFFIC MANAGER PROFILE
traffic_manager_profile_variables = {
  "traffic_manager_profile_1" = {
    traffic_manager_profile_dns_config_ttl = 2
    traffic_manager_profile_max_return     = 2 # Possible values range from 1 to 8
    traffic_manager_profile_monitor_config = {
      monitor_config_protocol                     = "HTTPS" # Possible values are HTTP, HTTPS, TCP
      monitor_config_port                         = 443
      monitor_config_path                         = "/"
      monitor_config_interval_in_seconds          = 30
      monitor_config_timeout_in_seconds           = 10
      monitor_config_tolerated_number_of_failures = 3 # Possible values are between 0 and 9
      monitor_config_expected_status_code_ranges  = ["100-200", "300-400"]
      monitor_config_custom_header = [
        {
          monitor_config_custom_header_name  = "host"
          monitor_config_custom_header_value = "www.contoso.com"
        }
      ]
    }
    traffic_manager_profile_name                = "ploceustraf000001"
    traffic_manager_profile_relative_name       = "ploceustrafdns000001"
    traffic_manager_profile_status              = "Enabled"
    traffic_manager_profile_resource_group_name = "ploceusrg00000102"
    traffic_manager_profile_tags = {
      "Created_By" = "Ploceus"
      "Department" = "CIS"
    }
    traffic_manager_profile_traffic_routing_method = "Performance" # Possible values are Geographic, MultiValue, Performance, Priority, Subnet, Weighted
    traffic_manager_profile_traffic_view_enabled   = true
  }
}

#PUBLIC IP
public_ip_variables = {
  "public_ip_1" = {
    name                    = "ploceuspublicip000002a"
    resource_group_name     = "ploceusrg00000103"
    location                = "eastus2"
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
traffic_manager_azure_endpoint_variables = {
  "traffic_manager_azure_endpoint_endpoint1" = {
    traffic_manager_azure_endpoint_name                = "ploceusazureendpoint000001"
    traffic_manager_azure_endpoint_resource_group_name = "ploceusrg00000102"
    traffic_manager_azure_endpoint_weight              = "150"
    traffic_manager_azure_endpoint_enabled             = true
    traffic_manager_azure_endpoint_geo_mappings        = ["WORLD"]
    traffic_manager_azure_endpoint_priority            = "100"
    traffic_manager_azure_endpoint_custom_header = [{
      custom_header_name  = "ploeuscustomheader"
      custom_header_value = "ploceus.com"
    }]
    traffic_manager_azure_endpoint_subnet = [{
      subnet_first = "10.0.0.0"
      subnet_last  = "10.0.0.255"
      subnet_scope = "24"
    }]
    traffic_manager_azure_endpoint_traffic_manager_profile_profile_name                  = "ploceustraf000001"
    traffic_manager_azure_endpoint_traffic_manager_profile_profile_resource_group_name   = "ploceusrg00000102"
    traffic_manager_azure_endpoint_traffic_manager_public_ip_profile_resource_group_name = "ploceusrg00000103"
    traffic_manager_azure_endpoint_traffic_manager_public_ip_name                        = "ploceuspublicip000002a"

  }
}

##Inputs to cross subscription checking variables 
public_ip_subscription_id       = "xxxxxxx-xxxxxxxx-xxxxxx-xxxxxxxx"
public_ip_tenant_id             = "xxxxxxx-xxxxxxxx-xxxxxx-xxxxxxxx"
traffic_manager_subscription_id = "xxxxxxx-xxxxxxxx-xxxxxx-xxxxxxxx"
traffic_manager_tenant_id       = "xxxxxxx-xxxxxxxx-xxxxxx-xxxxxxxx"