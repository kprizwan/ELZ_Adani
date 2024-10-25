#Logic App Standard Variables
variable "logic_app_standard_variables" {
  type = map(object({
    logic_app_standard_resource_group_name                  = string #Required
    logic_app_standard_storage_account_name                 = string #Required
    logic_app_standard_storage_account_resource_group_name  = string #Required
    logic_app_standard_app_service_plan_resource_group_name = string #Required
    logic_app_standard_resource_group_location              = string #Required
    logic_app_standard_app_service_plan_name                = string #Required
    logic_app_standard_name                                 = string #Required
    logic_app_standard_app_settings                         = map(string)
    logic_app_standard_use_extension_bundle                 = bool   #Defaults to true
    logic_app_standard_bundle_version                       = string #If use_extension_bundle=true then controls the allowed range for bundle versions. Default [1.*, 2.0.0)

    is_connection_string_required = bool #Variable to ask user whether connection string is required
    logic_app_standard_connection_string = object({
      name = string
      type = string #Possible values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer.
    })

    logic_app_standard_client_affinity_enabled = bool
    logic_app_standard_client_certificate_mode = string #Possible values are Required and Optional.
    logic_app_standard_enabled                 = bool
    logic_app_standard_https_only              = bool #Defaults to false.

    logic_app_standard_identity = object({
      type = string #The only possible value is SystemAssigned.
    })

    is_subnet_required = bool #Variable to ask user whether subnet is required
    logic_app_standard_site_config = list(object({
      always_on       = bool   #Defaults to false
      app_scale_limit = string #Only applicable to apps on the Consumption and Premium plan.
      cors = list(object({
        allowed_origins     = list(string) # '*' can be used to allow all calls.
        support_credentials = bool
      }))
      dotnet_framework_version = string #The version of the .NET framework's CLR used in this Logic App Possible values are v4.0 (including .NET Core 2.1 and 3.1), v5.0 and v6.0. Defaults to v4.0.
      elastic_instance_minimum = string
      ftps_state               = string #Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to AllAllowed.
      health_check_path        = string
      http2_enabled            = bool #Defaults to false.
      ip_restriction = list(object({
        ip_address  = string
        service_tag = string #One of either ip_address, service_tag or virtual_network_subnet_id must be specified
        name        = string
        priority    = string #The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified.
        action      = string #Does this restriction Allow or Deny access for this IP range. Defaults to Allow.
        headers = object({
          x_azure_fdid      = list(string)
          x_fd_health_probe = list(string)
          x_forwarded_for   = list(string)
          x_forwarded_host  = list(string)
        })
      }))
      linux_fx_version                 = string #Linux App Framework and version for the AppService, e.g. DOCKER|(golang:latest). Setting this value will also set the kind of application deployed to functionapp,linux,container,workflowapp
      min_tls_version                  = string #Possible values are 1.0, 1.1, and 1.2. Defaults to 1.2
      pre_warmed_instance_count        = string
      runtime_scale_monitoring_enabled = bool #Defaults to false.
      use_32_bit_worker_process        = bool #Defaults to true.
      vnet_route_all_enabled           = bool
      websockets_enabled               = bool
    }))

    logic_app_standard_storage_account_share_name = string
    logic_app_standard_version                    = string #The runtime version associated with the Logic App Defaults to ~1.
    logic_app_standard_tags                       = map(string)
    key_vault_name                                = string
    key_vault_resource_group_name                 = string
    secret_connection_string_value_name           = string
    subnet_name                                   = string
    vnet_name                                     = string
    subnet_resource_group_name                    = string
  }))
}