#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name       = "ploceusrg000001" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location   = "eastus2"         #(Required) The Azure Region where the Resource Group should exist.
    resource_group_managed_by = "ploceus"         #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      Created_By = "Ploceus",
      Department = "CIS"
    }
  }
}

#API MANAGEMENT
api_management_variables = {
  "api_management_1" = {
    api_management_name                                      = "ploceusapim000001" #(Required) The name of the API Management Service. Changing this forces a new resource to be created.
    api_management_location                                  = "eastus2"           #(Required) The Azure location where the API Management Service exists. Changing this forces a new resource to be created.
    api_management_resource_group_name                       = "ploceusrg000001"   #(Required) The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created.
    api_management_publisher_name                            = "ploceus"           #(Required) The name of publisher/company.
    api_management_publisher_email                           = "xxxxx@ploceus.com" #(Required) The email of publisher/company.
    api_management_sku_name                                  = "Developer_1"       #(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).
    api_management_additional_location                       = null
    api_management_certificate_key_vault_name                = null #(Optional) Only required if api_management_certificate block is passed. The key vault where Base64 encoded certificate and certificate password is stored
    api_management_certificate_key_vault_resource_group_name = null #(Optional) Only required if api_management_certificate block is passed. The key vault resource group, where Base64 encoded certificate and certificate password is stored
    api_management_certificate                               = null
    api_management_delegation                                = null
    api_management_client_certificate_enabled                = null  #(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption.
    api_management_gateway_disabled                          = false #(Optional) Disable the gateway in main region? This is only supported when additional_location is set.
    api_management_min_api_version                           = null  #(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than.
    api_management_zones                                     = null  #(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created.
    api_management_identity                                  = null
    api_management_hostname_configuration                    = null #(Optional) A hostname_configuration block as defined below.
    api_management_notification_sender_email                 = null #(Optional) Email address from which the notification will be sent.
    api_management_policy                                    = null
    api_management_protocols                                 = null
    api_management_security                                  = null
    api_management_sign_in                                   = null
    api_management_sign_up                                   = null
    api_management_tenant_access = { #(Optional) A tenant_access block as defined below.
      tenant_access_enabled = true   #(Required) Should the access to the management API be enabled?
    }
    api_management_public_ip_address_name                = null   #(Optional) name of a standard SKU IPv4 Public IP.
    api_management_public_ip_address_resource_group_name = null   #(Optional) resource group of a standard SKU IPv4 Public IP.
    api_management_public_network_access_enabled         = true   #(Optional) Is public access to the service allowed?. Defaults to true
    api_management_virtual_network_type                  = "None" #(Optional) The type of virtual network you want to use, valid values include: None, External, Internal. virtual_network_type is Internal or External. And please ensure other necessary ports are open according to api management network configuration.
    api_management_virtual_network_configuration         = null
    api_management_tags = { #(Optional) A mapping of tags assigned to the resource.
      Created_By = "Ploceus"
      Department = "CIS"
    }
  }
}

#API MANAGEMENT GATEWAY
api_management_gateway_variables = {
  "api_management_gateway_1" = {
    api_management_gateway_description                        = "API Management gateway" #(Optional) The description of the API Management Gateway.
    api_management_gatewayapi_management_gateway_name         = "ploceusapimg000001"     #(Required) The name which should be used for the API Management Gateway. Changing this forces a new API Management Gateway to be created.
    api_management_gateway_api_management_name                = "ploceusapim000001"      #(Required)The name of the API Management Service in which the gateway will be created.
    api_management_gateway_api_management_resource_group_name = "ploceusrg000001"        #(Required) The resource group name of the API Management Service in which the gateway will be created.
    api_management_gateway_city                               = null                     #(Optional) The city or locality where the resource is located.
    api_management_gateway_district                           = null                     #(Optional) The district, state, or province where the resource is located.
    api_management_gateway_name                               = "ploceusld000001"        #(Required) A canonical name for the geographic or physical location.
    api_management_gateway_region                             = null                     #(Optional) The country or region where the resource is located.
  }
}