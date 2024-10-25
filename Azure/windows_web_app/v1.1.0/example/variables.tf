#Windows web app RESOURCE GROUP VARIABLES
variable "windows_web_app_resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#Key Vault RESOURCE GROUP VARIABLES
variable "key_vault_resource_group_variables" {
  description = "Map of Resource groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_tags = map(string)
  }))
  default = {}
}

#APP SERVICE PLAN VARIABLE
variable "app_service_plan_variables" {
  description = "Map of object of service plan variables"
  default     = {}
  type = map(object({
    name                             = string
    resource_group_name              = string
    location                         = string
    os_type                          = string
    maximum_elastic_worker_count     = number
    worker_count                     = number
    app_service_environment_required = bool
    app_service_environment_name     = string
    sku_name                         = string /*The SKU for the app service plan.Possible values include B1,B2,B3,D1,F1,FREE,I1,I2,I3,I1v2,I2v2,I3v2,P1v2,P2v2,P3v2,
    P1v3,P2v3,P3v3,S1,S2,S3,SHARED,EP1,EP2,EP3,WS1,WS2,WS3.
    Note: Isolated SKUs (I1,I2,I3,I1v2,I2v2,and I3v2) can only be used with App Service Environments.
    Note: Elastic and Consumption SKUs(Y1,EP1,EP2,and EP3) are for use with Function Apps.
    Note: F1,B1,B2,B3 can only be used for Dev/Test less demanding workloads.
    Note: P1v2,P2v2,P3v2,P1v3,P2v3,P3v3,S1,S2,S3 can only be used for most production workloads.*/
    per_site_scaling_enabled         = bool
    zone_balancing_enabled           = bool
    app_service_plan_tags            = map(string)
  }))
}

#USER ASSIGNED IDENTITY VARIABLES
variable "user_assigned_identity_variables" {
  description = "Map of user assigned identity variables"
  type = map(object({
    user_assigned_identity_name                = string
    user_assigned_identity_location            = string
    user_assigned_identity_resource_group_name = string
    user_assigned_identity_tags                = map(string)
  }))
  default = {}
}

#API Management Variables
variable "api_management_variables" {
  type = map(object({
    api_management_name                = string                                #(Required) The name of the API Management Service. Changing this forces a new resource to be created.
    api_management_location            = string                                #(Required) The Azure location where the API Management Service exists. Changing this forces a new resource to be created.
    api_management_resource_group_name = string                                #(Required) The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created.
    api_management_publisher_name      = string                                #(Required) The name of publisher/company.
    api_management_publisher_email     = string                                #(Required) The email of publisher/company.
    api_management_sku_name            = string                                #(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).
    api_management_additional_location = list(object({                         #(Optional) One or more additional_location blocks as defined below.
      additional_location_location                              = string       #(Required) The name of the Azure Region in which the API Management Service should be expanded to.
      additional_location_capacity                              = number       #(Optional) The number of compute units in this region. Defaults to the capacity of the main region.
      additional_location_zones                                 = list(string) #(Optional) A list of availability zones.
      additional_location_public_ip_address_name                = string       #(Optional) name of a standard SKU IPv4 Public IP.
      additional_location_public_ip_address_resource_group_name = string       #(Optional) resource group name of a standard SKU IPv4 Public IP.
      additional_location_virtual_network_configuration = object({             #(Optional) A virtual_network_configuration block as defined below. Required when virtual_network_type is External or Internal.
        virtual_network_configuration_subnet_name                = string      #(Required) The id of the subnet that will be used for the API Management.
        virtual_network_configuration_virtual_network_name       = string      #(Required) The id of the subnet that will be used for the API Management.
        virtual_network_configuration_subnet_resource_group_name = string      #(Required) The id of the subnet that will be used for the API Management.
      })
    }))
    api_management_certificate_key_vault_name                = string #(Optional) Only required if api_management_certificate block is passed. The key vault where Base64 encoded certificate and certificate password is stored
    api_management_certificate_key_vault_resource_group_name = string #(Optional) Only required if api_management_certificate block is passed. The key vault resource group, where Base64 encoded certificate and certificate password is stored
    api_management_certificate = list(object({                        #(Optional) One or more (up to 10) certificate blocks as defined below.
      certificate_encoded_certificate_secret_name  = string           #(Required) The key vault secret where Base64 Encoded PFX or Base64 Encoded X.509 Certificate is stored. this is referred from api_management_certificate_key_vault_name
      certificate_store_name                       = string           #(Required) The name of the Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root.
      certificate_certificate_password_secret_name = string           #(Optional) The key vault secret where password for the certificate is stored. this is referred from api_management_certificate_key_vault_name
    }))
    api_management_client_certificate_enabled = bool         #(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption.
    api_management_gateway_disabled           = bool         #(Optional) Disable the gateway in main region? This is only supported when additional_location is set.
    api_management_min_api_version            = string       #(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than.
    api_management_zones                      = list(string) #(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created.
    api_management_identity = object({                       #(Optional) An identity block as defined below.
      identity_type = string                                 #(Required) Specifies the type of Managed Service Identity that should be configured on this API Management Service. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
      identity_user_assigned_identities = list(object({      #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this API Management Service. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        user_identity_name                = string           #user assigned identity name Required if identity type ="systemassigned" or "systemassigned,userassigned"
        user_identity_resource_group_name = string           #resource group name of the user identity
      }))
    })
    api_management_hostname_configuration = object({                              #(Optional) A hostname_configuration block as defined below.
      hostname_configuration_key_vault_name                              = string #(Optional) The name of the Key Vault containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
      hostname_configuration_key_vault_resource_group_name               = string #(Optional) The resource group of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
      hostname_configuration_ssl_keyvault_identity_client_type           = string #(Optional) Possible values are SystemAssigned, UserAssigned. Pass null if not required
      hostname_configuration_ssl_keyvault_identity_client_id             = string #(Optional) The client id of the System or User Assigned Managed identity generated by Azure AD, which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_ssl_keyvault_identity_client_name           = string #(Optional) The User Assigned Managed identity name , which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_ssl_keyvault_identity_client_resource_group = string #(Optional) The User Assigned Managed identity resource group name , which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
      hostname_configuration_management = list(object({                           #(Optional) One or more management blocks as documented below.
        management_host_name                    = string                          #(Required) The Hostname to use for the Management API.
        management_key_vault_secret_name        = string                          #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12. Setting this field requires the identity block to be specified, since this identity is used for to retrieve the Key Vault Certificate. Auto-updating the Certificate from the Key Vault requires the Secret version isn't specified.
        management_negotiate_client_certificate = bool                            #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))

      hostname_configuration_portal = list(object({  #(Optional) One or more portal blocks as documented below.
        portal_host_name                    = string #(Required) The Hostname to use for the Management API.
        portal_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        portal_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))

      hostname_configuration_developer_portal = list(object({  #(Optional) One or more developer_portal blocks as documented below.
        developer_portal_host_name                    = string #(Required) The Hostname to use for the Management API.
        developer_portal_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        developer_portal_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))

      hostname_configuration_proxy = list(object({  #(Optional) One or more proxy blocks as documented below.
        proxy_default_ssl_binding          = bool   #(Optional) Is the certificate associated with this Hostname the Default SSL Certificate? This is used when an SNI header isn't specified by a client. Defaults to false.
        proxy_host_name                    = string #(Required) The Hostname to use for the Management API.
        proxy_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        proxy_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))
      hostname_configuration_scm = list(object({  #(Optional) One or more scm blocks as documented below.
        scm_host_name                    = string #(Required) The Hostname to use for the Management API.
        scm_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
        scm_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
      }))
    })
    api_management_notification_sender_email = string #(Optional) Email address from which the notification will be sent.
    api_management_policy = object({                  #(Optional) A policy block as defined below.
      policy_xml_content = string                     #(Optional) The XML Content for this Policy.
      policy_xml_link    = string                     #(Optional) A link to an API Management Policy XML Document, which must be publicly available.
    })
    api_management_protocols = object({ #(Optional) A protocols block as defined below.
      protocols_enable_http2 = bool     #(Optional) Should HTTP/2 be supported by the API Management Service? Defaults to false.
    })
    api_management_security = object({                                    #(Optional) A security block as defined below.
      security_enable_backend_ssl30                                = bool #(Optional) Should SSL 3.0 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30 field
      security_enable_backend_tls10                                = bool #(Optional) Should TLS 1.0 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10 field
      security_enable_backend_tls11                                = bool #(Optional) Should TLS 1.1 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11 field
      security_enable_frontend_ssl30                               = bool #(Optional) Should SSL 3.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30 field
      security_enable_frontend_tls10                               = bool #(Optional) Should TLS 1.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10 field
      security_enable_frontend_tls11                               = bool #(Optional) Should TLS 1.1 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11 field
      security_tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = bool #(Optional) Should the TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA field
      security_tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = bool #(Optional) Should the TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA field
      security_tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = bool #(Optional) Should the TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA field
      security_tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = bool #(Optional) Should the TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA field
      security_tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_128_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA256 field
      security_tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = bool #(Optional) Should the TLS_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA field
      security_tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_128_GCM_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_GCM_SHA256 field
      security_tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_256_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA256 field
      security_tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = bool #(Optional) Should the TLS_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA field
      security_triple_des_ciphers_enabled                          = bool #(Optional) Should the TLS_RSA_WITH_3DES_EDE_CBC_SHA cipher be enabled for alL TLS versions (1.0, 1.1 and 1.2)? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168 field
    })
    api_management_sign_in = object({ #(Optional) A sign_in block as defined below.
      sign_in_enabled = bool          #(Required) Should anonymous users be redirected to the sign in page?
    })
    api_management_sign_up = object({              #(Optional) A sign_up block as defined below.
      sign_up_enabled = bool                       #(Required) Can users sign up on the development portal?
      sign_up_terms_of_service = object({          #(Required) A terms_of_service block as defined below.
        terms_of_service_consent_required = bool   #(Required) Should the user be asked for consent during sign up?
        terms_of_service_enabled          = bool   #(Required) Should Terms of Service be displayed during sign up?.
        terms_of_service_text             = string #(Required) The Terms of Service which users are required to agree to in order to sign up.
      })
    })
    api_management_tenant_access = object({ #(Optional) A tenant_access block as defined below.
      tenant_access_enabled = bool          #(Required) Should the access to the management API be enabled?
    })
    api_management_public_ip_address_name                = string       #(Optional) name of a standard SKU IPv4 Public IP.
    api_management_public_ip_address_resource_group_name = string       #(Optional) resource group of a standard SKU IPv4 Public IP.
    api_management_public_network_access_enabled         = bool         #(Optional) Is public access to the service allowed?. Defaults to true
    api_management_virtual_network_type                  = string       #(Optional) The type of virtual network you want to use, valid values include: None, External, Internal. virtual_network_type is Internal or External. And please ensure other necessary ports are open according to api management network configuration.
    api_management_virtual_network_configuration = object({             #(Optional) A virtual_network_configuration block as defined below. Required when virtual_network_type is External or Internal.
      virtual_network_configuration_subnet_name                = string #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_virtual_network_name       = string #(Required) The id of the subnet that will be used for the API Management.
      virtual_network_configuration_subnet_resource_group_name = string #(Required) The id of the subnet that will be used for the API Management.
    })
    api_management_tags = map(string) #(Optional) A mapping of tags assigned to the resource.
  }))
  description = "Map of API Management Object"
  default     = {}
}

#API MANAGEMENT API VARIABLES
variable "api_management_api_variables" {
  type = map(object({
    api_management_api_name                  = string       #(Required) The name of the API Management API. Changing this forces a new resource to be created.
    api_management_api_resource_group_name   = string       #(Required) The Name of the Resource Group where the API Management API exists. Changing this forces a new resource to be created.
    api_management_api_api_management_name   = string       #(Required) The Name of the API Management Service where this API should be created. Changing this forces a new resource to be created.
    api_management_api_revision              = string       #(Required) The Revision which used for this API.
    api_management_api_revision_description  = string       #(Optional) The description of the API Revision of the API Management API.
    api_management_api_display_name          = string       #(Optional) The display name of the API.
    api_management_api_description           = string       #(Optional) A description of the API Management API, which may include HTML formatting tags.
    api_management_api_path                  = string       #(Optional) The Path for this API Management API, which is a relative URL which uniquely identifies this API and all of its resource paths within the API Management Service.
    api_management_api_service_url           = string       #(Optional) Absolute URL of the backend service implementing this API.
    api_management_api_protocols             = list(string) #(Optional) A list of protocols the operations in this API can be invoked. Possible values are http and https.
    api_management_api_soap_pass_through     = bool         #(Optional) Should this API expose a SOAP frontend, rather than a HTTP frontend? Defaults to false.
    api_management_api_subscription_required = bool         #(Optional) Should this API require a subscription key?
    api_management_api_version               = string       #(Optional) The Version number of this API, if this API is versioned.
    api_management_api_version_set_id        = string       #(Optional) The ID of the Version Set which this API is associated with.
    api_management_api_version_description   = string       #(Optional) The description of the API Version of the API Management API.
    api_management_api_source_api_id         = string       #(Optional) The API id of the source API, which could be in format azurerm_api_management_api.example.id or in format azurerm_api_management_api.example.id;rev=1
    api_management_api_import = object({                    #(Optional) A import block as documented below.
      api_management_api_import_content_format = string     #(Required) The format of the content from which the API Definition should be imported. Possible values are: openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl and wsdl-link.
      api_management_api_import_content_value  = string     #(Required) The Content from which the API Definition should be imported. When a content_format of *-link-* is specified this must be a URL, otherwise this must be defined inline.
      api_management_api_import_wsdl_selector = object({    #(Optional) A wsdl_selector block as defined below, which allows you to limit the import of a WSDL to only a subset of the document. This can only be specified when content_format is wsdl or wsdl-link.
        import_wsdl_selector_service_name  = string         #(Required) The name of service to import from WSDL.
        import_wsdl_selector_endpoint_name = string         #(Required) The name of endpoint (port) to import from WSDL.
      })
    })
    api_management_api_oauth2_authorization = object({ #(Optional) An oauth2_authorization block as documented below.
      oauth2_authorization_server_name = string        #(Required) OAuth authorization server identifier. The name of an OAuth2 Authorization Server.
      oauth2_authorization_scope       = string        #(Optional) Operations scope.
    })
    api_management_api_openid_authentication = object({                 #(Optional) An openid_authentication block as documented below.
      openid_authentication_openid_provider_name         = string       #(Required) OpenID Connect provider identifier. The name of an OpenID Connect Provider.
      openid_authentication_bearer_token_sending_methods = list(string) #(Optional) How to send token to the server. A list of zero or more methods. Valid values are authorizationHeader and query.
    })
    api_management_api_subscription_key_parameter_names = object({ #(Optional) A subscription_key_parameter_names block
      subscription_key_parameter_names_header = string             #(Required) The name of the HTTP Header which should be used for the Subscription Key.
      subscription_key_parameter_names_query  = string             #(Required) The name of the QueryString parameter which should be used for the Subscription Key.
    })
  }))
  description = "Map of object for api managemnet api details"
  default     = {}
}

#KEY VAULT
variable "key_vault_variables" {
  description = "Map of object of key vault varaibles"
  default     = {}
  type = map(object({
    key_vault_name                                  = string
    key_vault_resource_group_name                   = string
    key_vault_location                              = string
    key_vault_enabled_for_disk_encryption           = bool
    key_vault_enabled_for_deployment                = bool
    key_vault_enabled_for_template_deployment       = bool
    key_vault_enable_rbac_authorization             = bool
    key_vault_soft_delete_retention_days            = string
    key_vault_purge_protection_enabled              = bool
    key_vault_sku_name                              = string
    key_vault_access_container_agent_name           = string
    key_vault_access_policy_key_permissions         = list(string)
    key_vault_access_policy_secret_permissions      = list(string)
    key_vault_access_policy_storage_permissions     = list(string)
    key_vault_access_policy_certificate_permissions = list(string)
    key_vault_tags                                  = map(string)
    key_vault_network_acls_enabled                  = bool
    key_vault_network_acls_bypass                   = string
    key_vault_network_acls_default_action           = string
    key_vault_network_acls_ip_rules                 = list(string)
    key_vault_network_acls_virtual_networks = list(object({
      virtual_network_name    = string
      subnet_name             = string
      subscription_id         = string
      virtual_network_rg_name = string
    }))
    key_vault_contact_information_enabled = bool
    key_vault_contact_email               = string
    key_vault_contact_name                = string
    key_vault_contact_phone               = string
  }))
}

#KEY VAULT SECRET VARIABLES
variable "key_vault_secret_variables" {
  description = "Map of object of key vault secret variables"
  default     = {}
  type = map(object({
    key_vault_name                       = string
    key_vault_secret_value               = string
    key_vault_secret_content_type        = string
    key_vault_secret_not_before_date     = string
    key_vault_secret_expiration_date     = string
    key_vault_secret_resource_group_name = string
    key_vault_secret_name                = string
    key_vault_secret_tags                = map(string)
    key_vault_secret_min_upper           = number
    key_vault_secret_min_lower           = number
    key_vault_secret_min_numeric         = number
    key_vault_secret_min_special         = number
    key_vault_secret_length              = number
  }))
}

#KEY VAULT KEY
variable "key_vault_key_variables" {
  description = "Map of object of key vault key variables"
  default     = {}
  type = map(object({
    name                = string
    resource_group_name = string
    key_vault_name      = string
    key_type            = string
    key_size            = number
    curve               = string
    key_opts            = list(string)
    not_before_date     = string
    expiration_date     = string
    key_vault_key_tags  = map(string)
  }))
}

#STORAGE ACCOUNT VARIABLES
variable "storage_account_variables" {
  description = "Map of object of storage account variables"
  default     = {}
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    account_tier                      = string
    account_replication_type          = string
    account_kind                      = string
    access_tier                       = string
    enable_https_traffic_only         = bool
    min_tls_version                   = string
    allow_nested_items_to_be_public   = bool
    large_file_share_enabled          = bool
    nfsv3_enabled                     = bool
    is_hns_enabled                    = bool
    cross_tenant_replication_enabled  = bool
    shared_access_key_enabled         = bool
    edge_zone                         = string
    infrastructure_encryption_enabled = bool

    custom_domain = list(object({
      name          = string
      use_subdomain = bool
    }))

    identity = list(object({
      type         = string
      identity_ids = list(string)
    }))

    routing = list(object({
      publish_internet_endpoints  = bool
      publish_microsoft_endpoints = bool
      choice                      = string
    }))

    azure_files_authentication = list(object({
      directory_type = string
      active_directory = object({
        storage_sid         = string
        domain_name         = string
        domain_sid          = string
        domain_guid         = string
        forest_name         = string
        netbios_domain_name = string
      })
    }))

    customer_managed_key = list(object({
      key_vault_key_id          = string
      user_assigned_identity_id = string
    }))

    share_properties = list(object({
      retention_policy = object({
        days = number
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
      smb = list(object({
        versions                        = list(string)
        authentication_types            = list(string)
        kerberos_ticket_encryption_type = list(string)
        channel_encryption_type         = list(string)
      }))
    }))


    network_rules = list(object({
      default_action = string
      bypass         = list(string)
      ip_rules       = list(string)
      private_link_access = object({
        endpoint_resource_id = string
        endpoint_tenant_id   = string
      })
    }))

    queue_properties = list(object({
      logging = object({
        delete                = bool
        read                  = bool
        version               = string
        write                 = bool
        retention_policy_days = string
      })
      hour_metrics = object({
        enabled               = bool
        include_apis          = bool
        retention_policy_days = string
        version               = string
      })
      minute_metrics = object({
        enabled               = bool
        include_apis          = bool
        retention_policy_days = string
        version               = string
      })
      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
    }))
    storage_account_tags = map(string)
    blob_properties = list(object({
      enable_versioning        = bool
      last_access_time_enabled = bool
      default_service_version  = string
      change_feed_enabled      = bool
      delete_retention_policy = object({
        blob_retention_policy = string
      })
      container_delete_retention_policy = object({
        container_delete_retention_policy = string
      })

      cors_rule = list(object({
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      }))
    }))
    static_website = object({
      index_path      = string
      custom_404_path = string
    })
  }))

}

#STORAGE CONTAINER VARIABLES
variable "storage_container_variables" {
  description = "Map of object of storage container variables"
  default     = {}
  type = map(object({
    name                  = string
    storage_account_name  = string
    container_access_type = string
    metadata              = map(string)
  }))
}

#VNET variable
variable "vnets_variables" {
  description = "Map of vnet object variables"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    address_space               = list(string)
    dns_servers                 = list(string)
    flow_timeout_in_minutes     = number
    bgp_community               = string
    is_ddos_protection_required = bool
    ddos_protection_plan_name   = string
    vnet_tags                   = map(string)
    edge_zone                   = string
  }))
  default = {}
}

#Subnet Variables
variable "subnet_variables" {
  description = "Map of object of subnet variables"
  default     = {}
  type = map(object({
    name                                           = string
    resource_group_name                            = string
    virtual_network_name                           = string
    address_prefixes                               = list(string)
    enforce_private_link_service_network_policies  = bool
    enforce_private_link_endpoint_network_policies = bool
    service_endpoints                              = list(string)
    is_delegetion_required                         = bool
    delegation_name                                = string
    service_name                                   = string
    service_actions                                = list(string)
  }))
}

#CONTAINER REGISTRY VARIABLES
variable "container_registry_variables" {
  description = "The map of object of container registry variables"
  default     = {}
  type = map(object({
    container_registry_name                                     = string
    container_registry_resource_group_name                      = string
    container_registry_location                                 = string
    container_registry_sku                                      = string
    container_registry_admin_enabled                            = bool
    container_registry_export_policy_enabled                    = bool
    container_registry_georeplication_enabled                   = bool
    container_registry_georeplication_location                  = string
    container_registry_georeplication_zone_redundancy_enabled   = bool
    container_registry_georeplication_regional_endpoint_enabled = bool
    container_registry_public_network_access_enabled            = bool
    container_registry_quarantine_policy_enabled                = bool
    container_registry_retention_policy = object({
      policy_enabled = bool
      policy_days    = string
    })
    container_registry_regional_endpoint_enabled = bool
    container_registry_zone_redundancy_enabled   = bool
    container_registry_trust_policy = object({
      enabled = bool
    })
    container_registry_data_endpoint_enabled      = bool
    container_registry_anonymous_pull_enabled     = bool
    container_registry_network_rule_bypass_option = string
    is_container_registry_encryption_required     = bool
    container_registry_encryption = object({
      container_registry_encryption_enabled                      = bool
      identity_name                                              = string
      identity_resource_group_name                               = string
      container_registry_encryption_keyvault_name                = string
      container_registry_encryption_keyvault_key_name            = string
      container_registry_encryption_keyvault_resource_group_name = string
    })
    is_container_registry_identity_required = bool
    container_registry_identity = object({
      identity_type = string
      user_assigned_identities = list(object({
        identity_name                = string
        identity_resource_group_name = string
      }))
    })
    container_registry_network_rule_set_enabled = bool
    container_registry_network_rule_set = object({
      default_action          = string
      ip_rule_enabled         = bool
      ip_rule_action          = string
      ip_rule_range           = string
      virtual_network_enabled = bool
      virtual_network = list(object({
        action                     = string
        virtual_network_name       = string
        subnet_name                = string
        subnet_resource_group_name = string
      }))
    })
    container_registry_container_registry_tags  = map(string)
    container_registry_georeplication_zone_tags = map(string)
  }))
}

#WINDOWS WEB APP VARIABLES
variable "windows_web_app_variables" {
  description = "The map of object of windows web app variables"
  default     = {}
  type = map(object({
    windows_web_app_service_plan_name                = string #(Required) The name of the Service Plan that this Windows App Service will be created in.
    windows_web_app_service_plan_resource_group_name = string #(Required) The resource group name of the Service Plan that this Windows App Service will be created in.

    windows_web_app_key_vault_user_assigned_identity_enabled             = bool   #(Optional) Should user assigned identity for key_vault be enabled to access key_vault secrets. This identity must also be present in windows_web_app_identity block.
    windows_web_app_key_vault_user_assigned_identity_name                = string #(Optional) The key_vault User Assigned Identity name used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block.
    windows_web_app_key_vault_user_assigned_identity_resource_group_name = string #(Optional) The key_vault User Assigned Identity resource group name used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block.
    windows_web_app_key_vault_name                                       = string #(Optional) The key vault name.
    windows_web_app_key_vault_resource_group_name                        = string #(Optional) The key vault resource group name.

    windows_web_app_storage_container_name = string #(Optional) The name of storage container required for blob container sas url.
    storage_account = list(object({
      storage_account_name                = string #(Optional) The backend storage account name which will be used by this Function App.
      storage_account_resource_group_name = string #(Optional) The backend storage account resource group name which will be used by this Function App.
    }))

    windows_web_app_api_management_api_name            = string #(Optional) The name of the API Management API.
    windows_web_app_api_management_name                = string #(Optional) The name of the API Management Service in which the API Management API exists.
    windows_web_app_api_management_resource_group_name = string #(Optional) The Name of the Resource Group in which the API Management Service exists.
    windows_web_app_api_management_api_revision        = string #(Optional) The Revision of the API Management API.

    windows_web_app_container_registry_name                = string #(Optional) This is required if in site_config block site_config_container_registry_use_managed_identity is set to true.
    windows_web_app_container_registry_resource_group_name = string #(Optional) This is required if in site_config block site_config_container_registry_use_managed_identity is set to true.

    windows_web_app_ip_restriction_subnet_name                         = string #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_ip_restriction_virtual_network_name                = string #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_ip_restriction_virtual_network_resource_group_name = string #(Optional) This value is required if in windows_web_app_site config in ip_restriction_block , the value for "ip_restriction_virtual_network_subnet_id_enabled" is set to true.

    windows_web_app_scm_ip_restriction_subnet_name                         = string #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_scm_ip_restriction_virtual_network_name                = string #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.
    windows_web_app_scm_ip_restriction_virtual_network_resource_group_name = string #(Optional) This value is required if in windows_web_app_site config in scm_ip_restriction_block , the value for "scm_ip_restriction_virtual_network_subnet_id_enabled" is set to true.

    windows_web_app_name                       = string #(Required) The name which should be used for this Windows Web App.
    windows_web_app_location                   = string #(Required) The Azure Region where the Windows Web App should exist.
    windows_web_app_resource_group_name        = string #(Required) The name of the Resource Group where the Windows Web App should exist.
    windows_web_app_client_affinity_enabled    = bool   #(Optional) Should Client Affinity be enabled?
    windows_web_app_client_certificate_enabled = bool   #(Optional) Should Client Certificates be enabled?
    windows_web_app_client_certificate_mode    = string #(Optional) The Client Certificate mode. Possible values include Optional and Required. This property has no effect when client_cert_enabled is false.
    windows_web_app_enabled                    = bool   #(Optional) Should the Windows Web App be enabled? Defaults to true.
    windows_web_app_https_only                 = bool   #(Optional) Should the Windows Web App require HTTPS connections.
    windows_web_app_zip_deploy_file            = string #(Optional) The local path and filename of the Zip packaged application to deploy to this Windows Web App.

    windows_web_app_app_settings = map(any) # (Optional) A map of key-value pairs of App Settings.

    windows_web_app_auth_settings_enabled = bool                     #(Optional) Should windows_web_app auth settings be enabled .
    windows_web_app_auth_settings = object({                         #(Optional) A auth_settings block as defined below.
      auth_settings_enabled                           = bool         #(Required) Should the Authentication / Authorization feature be enabled for the windows Web App?
      auth_settings_additional_login_parameters       = map(any)     #(Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
      auth_settings_allowed_external_redirect_urls    = list(string) #(Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the windows Web App.
      auth_settings_configure_multiple_auth_providers = bool         #(Optional) Should Multiple Authentication providers be configured ?
      auth_settings_default_provider                  = string       #(Optional) The default authentication provider to use when multiple providers are configured. Possible values include: AzureActiveDirectory, Facebook, Google, MicrosoftAccount, Twitter, Github
      auth_settings_runtime_version                   = string       #(Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the windows Web App.
      auth_settings_token_refresh_extension_hours     = number       #(Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
      auth_settings_token_store_enabled               = bool         #Optional) Should the windows Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
      auth_settings_unauthenticated_client_action     = string       #Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
      auth_settings_issuer                            = string       #(Optional) The OpenID Connect Issuer URI that represents the entity which issues access tokens for this windows Web App.

      auth_settings_active_directory = object({
        active_directory_enabled                             = bool         #(Required) should active directory authentication be enabled ?
        active_directory_client_id                           = string       #(Required) The ID of the Client to use to authenticate with Azure Active Directory.
        active_directory_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for active directory authentication. 
        active_directory_client_secret_setting_name          = string       #(Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
        active_directory_allowed_audiences                   = list(string) #(Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
      })
      auth_settings_facebook = object({
        facebook_enabled                          = bool         #(Required) should facebook authentication be enabled ?
        facebook_app_id                           = string       #(Required) The App ID of the Facebook app used for login.
        facebook_app_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        facebook_app_secret_setting_name          = string       #(Optional) The app setting name that contains the app_secret value used for Facebook login. Cannot be specified with app_secret.
        facebook_oauth_scopes                     = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
      })
      auth_settings_github = object({
        github_enabled                             = bool         #(Required) should github authentication be enabled ?
        github_client_id                           = string       # (Required) The ID of the GitHub app used for login.
        github_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        github_client_secret_setting_name          = string       #(Optional) The app setting name that contains the client_secret value used for GitHub login. Cannot be specified with client_secret.
        github_oauth_scopes                        = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
      })
      auth_settings_google = object({
        google_enabled                             = bool         #(Required) should google authentication be enabled ?
        google_client_id                           = string       # (Required) The ID of the google app used for login.
        google_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        google_client_secret_setting_name          = string       #(Optional) The app setting name that contains the client_secret value used for google login. Cannot be specified with client_secret.
        google_oauth_scopes                        = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, openid, profile, and email are used as default scopes.
      })
      auth_settings_microsoft = object({
        microsoft_enabled                             = bool         #(Required) should google authentication be enabled ?
        microsoft_client_id                           = string       # (Required) The ID of the microsoft app used for login.
        microsoft_client_secret_key_vault_secret_name = string       #(Optional) The Key vault Secret key name for facebook authentication.
        microsoft_client_secret_setting_name          = string       #(Optional) The app setting name that contains the client_secret value used for microsoft login. Cannot be specified with client_secret.
        microsoft_oauth_scopes                        = list(string) #(Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, wl.basic is used as the default scope.
      })
      auth_settings_twitter = object({
        twitter_enabled                               = bool   #(Required) should twitter authentication be enabled ?
        twitter_consumer_key_key_vault_secret_name    = string #(Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
        twitter_consumer_secret_key_vault_secret_name = string #(Optional) The Key vault Secret key name for twitter authentication.
        twitter_consumer_secret_setting_name          = string #(Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret.
      })
    })

    windows_web_app_backup_enabled = bool #(Optional) should backup be enabled for windows_web_app.
    windows_web_app_backup = object({     #(Optional) A backup block as defined below.
      backup_enabled = bool               #(Optional) Should this backup job be enabled?
      backup_name    = string             #(Required) The name which should be used for this Backup.
      backup_schedule = object({
        backup_schedule_frequency_interval       = number #(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day).
        backup_schedule_frequency_unit           = string #(Required) The unit of time for how often the backup should take place. Possible values include: Day and Hour.
        backup_schedule_keep_at_least_one_backup = bool   #(Optional) Should the service keep at least one backup, regardless of age of backup. Defaults to false.
        backup_schedule_retention_period_days    = number #(Optional) After how many days backups should be deleted.
        backup_schedule_start_time               = string #(Optional) When the schedule should start working in RFC-3339 format.
      })
    })

    windows_web_app_connection_string = map(object({         #(Optional) One or more connection_string blocks as defined below.
      connection_string_name                        = string #(Required) The name which should be used for this Connection.
      connection_string_type                        = string #(Required) Type of database. Possible values include: MySQL, SQLServer, SQLAzure, Custom, NotificationHub, ServiceBus, EventHub, APIHub, DocDb, RedisCache, and PostgreSQL.
      connection_string_value_key_vault_secret_name = string #(Required) The Key vault secret name containing value for each connection string type.
    }))

    windows_web_app_identity = object({                          #(Optional) A identity block as defined below.
      windows_web_app_identity_type = string                     #(Required) Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
      windows_web_app_user_assigned_identity_ids = list(object({ #(Optional) This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        identity_name                = string                    #(Required) The user assigned identity name.
        identity_resource_group_name = string                    #(Required) The user assigned identity resource group name.
      }))
    })

    windows_web_app_logs = object({       #(Optional) A logs block as defined below.
      logs_detailed_error_messages = bool #(Optional) Should detailed error messages be enabled.
      logs_failed_request_tracing  = bool #(Optional) Should tracing be enabled for failed requests.

      application_logs = object({                       #(Optional) A application_logs block as defined below.
        application_logs_file_system_level = string     #(Required) Log level. Possible values include: Verbose, Information, Warning, and Error.
        application_logs_azure_blob_storage = object({  #(Optional) A azure_blob_storage block as defined below.
          azure_blob_storage_level             = string #(Required) The level at which to log. Possible values include Error, Warning, Information, Verbose and Off. NOTE: this field is not available for http_logs.
          azure_blob_storage_retention_in_days = number #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
        })
      })

      http_logs = object({                              #(Optional) A http_logs block as defined below.
        http_logs_azure_blob_storage = object({         # (Optional) A azure_blob_storage block as defined below.
          azure_blob_storage_retention_in_days = number #(Required) The time in days after which to remove blobs. A value of 0 means no retention.
        })
        http_logs_file_system = object({         #(Optional) A file_system block as defined below.
          file_system_retention_in_days = number #(Required) The retention period in days. A values of 0 means no retention.
          file_system_retention_in_mb   = string #(Required) The maximum size in megabytes that log files can use.
        })
      })
    })

    windows_web_app_sticky_settings = object({      #(Optional) A sticky_settings block as defined below.
      sticky_app_setting_names       = list(string) #(Optional) A list of app_setting names that the windows_web_app will not swap between Slots when a swap operation is triggered.
      sticky_connection_string_names = list(string) #(Optional) A list of connection_string names that the windows_web_app will not swap between Slots when a swap operation is triggered.
    })

    windows_web_app_storage_account = map(object({ #(Optional) One or more storage_account blocks as defined below
      storage_account_name       = string          #(Required) The name which should be used for this Storage Account.
      storage_account_name       = string          #(Required) The name which should be used for this TODO.
      storage_account_share_name = string          #(Required) The Name of the File Share or Container Name for Blob storage.
      storage_account_type       = string          #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob.
      storage_account_mount_path = string          #(Optional) The path at which to mount the storage share.
    }))

    windows_web_app_site_config = object({                                                #(Required) A site_config block as defined below.
      site_config_always_on                                                = bool         #(Optional) If this Windows Web App is Always On enabled. Defaults to true.
      site_config_api_management_enabled                                   = bool         ##(Optional) Should API Management be enabled for this Windows web App.
      site_config_app_command_line                                         = string       #(Optional) The App command line to launch.
      site_config_auto_heal_enabled                                        = bool         #(Optional) Should Auto heal rules be enabled. Required with auto_heal_setting.
      site_config_container_registry_managed_idenitity_name                = string       #(Optional) The User assigned Managed Service Identity name to use for connections to the Azure Container Registry.
      site_config_container_registry_managed_idenitity_resource_group_name = string       #(Optional) The User assigned Managed Service Identity resource group name to use for connections to the Azure Container Registry.
      site_config_container_registry_use_managed_identity                  = bool         #(Optional) Should connections for Azure Container Registry use Managed Identity.
      site_config_default_documents                                        = list(string) #(Optional) Specifies a list of Default Documents for the Windows Web App.
      site_config_ftps_state                                               = string       #(Optional) The State of FTP / FTPS service. Possible values include: AllAllowed, FtpsOnly, Disabled.
      site_config_health_check_path                                        = string       #(Optional) The path to the Health Check.
      site_config_health_check_eviction_time_in_min                        = number       #(Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
      site_config_http2_enabled                                            = bool         #(Optional) Should the HTTP2 be enabled?
      site_config_load_balancing_mode                                      = string       #(Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
      site_config_local_mysql_enabled                                      = bool         #(Optional) Use Local MySQL. Defaults to false.
      site_config_managed_pipeline_mode                                    = string       #(Optional) Managed pipeline mode. Possible values include: Integrated, Classic.
      site_config_minimum_tls_version                                      = string       #(Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_remote_debugging_enabled                                 = bool         #(Optional) Should Remote Debugging be enabled. Defaults to false.
      site_config_remote_debugging_version                                 = string       #(Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019
      site_config_scm_minimum_tls_version                                  = string       #(Optional) The configures the minimum version of TLS required for SSL requests to the SCM site Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
      site_config_scm_use_main_ip_restriction                              = bool         #(Optional) Should the Windows Web App ip_restriction configuration be used for the SCM also.
      site_config_use_32_bit_worker                                        = bool         #(Optional) Should the Windows Web App use a 32-bit worker.
      site_config_websockets_enabled                                       = bool         #(Optional) Should Web Sockets be enabled. Defaults to false.
      site_config_worker_count                                             = number       #(Optional) The number of Workers for this Windows App Service.

      site_config_application_stack = object({               #(Optional) A application_stack block as defined below.
        application_stack_current_stack             = string #(Optional) The Application Stack for the Windows Web App. Possible values include dotnet, dotnetcore, node, python, php, and java.
        application_stack_docker_container_name     = string #(Optional) The name of the Docker Container. For example azure-app-service/samples/aspnethelloworld
        application_stack_docker_container_registry = string #(Optional) The registry Host on which the specified Docker Container can be located. For example mcr.microsoft.com
        application_stack_docker_container_tag      = string #(Optional) The Image Tag of the specified Docker Container to use. For example latest
        application_stack_dotnet_version            = string #(Optional) The version of .NET to use when current_stack is set to dotnet. Possible values include v3.0, v4.0, v5.0, and v6.0.
        application_stack_java_container            = string #(Optional) The Java container type to use when current_stack is set to java. Possible values include JAVA, JETTY, and TOMCAT. Required with java_version and java_container_version.
        application_stack_java_container_version    = string #(Optional) The Version of the java_container to use. Required with java_version and java_container.
        application_stack_java_version              = string #(Optional) The version of Java to use when current_stack is set to java. Possible values include 1.7, 1.8 and 11. Required with java_container and java_container_version.
        application_stack_node_version              = string #(Optional) The version of node to use when current_stack is set to node. Possible values include 12-LTS, 14-LTS, and 16-LTS.
        application_stack_php_version               = string #(Optional) The version of PHP to use when current_stack is set to php. Possible values include v7.4.
        application_stack_python_version            = string #(Optional) The version of Python to use when current_stack is set to python. Possible values include 2.7 and 3.4.0.
      })

      site_config_auto_heal_setting = object({
        auto_heal_setting_action = object({       #(Required) An action block as defined below.
          action_type                    = string # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle, LogEvent, and CustomAction.
          minimum_process_execution_time = string #(Optional) The minimum amount of time in hh:mm:ss the Windows Web App must have been running before the defined action will be run in the event of a trigger.
          custom_action = object({                #(Optional) A custom_action block as defined below.
            custom_action_executable = string     #(Required) The executable to run for the custom_action.
            custom_action_parameters = string     #(Optional) The parameters to pass to the specified executable.
          })
        })

        auto_heal_setting_trigger = object({ #(Required) A trigger block as defined below.
          trigger_private_memory_kb = number #(Optional) The amount of Private Memory to be consumed for this rule to trigger. Possible values are between 102400 and 13631488.
          trigger_requests = object({        # (Optional) A requests block as defined below.
            requests_count    = number       #(Required) The number of requests in the specified interval to trigger this rule.
            requests_interval = string       #(Required) The interval in hh:mm:ss.
          })

          trigger_slow_request = map(object({ #(Optional) One or more slow_request blocks as defined below.
            slow_request_count      = number  #(Required) The number of Slow Requests in the time interval to trigger this rule.
            slow_request_interval   = string  #(Required) The time interval in the form hh:mm:ss.
            slow_request_time_taken = string  #(Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
            slow_request_path       = string  #(Optional) The path for which this slow request rule applies.
          }))

          trigger_status_code = map(object({  #(Optional) One or more status_code blocks as defined above.
            status_code_count        = number #(Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
            status_code_interval     = string #(Required) The time interval in the form hh:mm:ss.
            status_code_range        = string #(Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
            status_code_path         = string #(Optional) The path to which this rule status code applies.
            status_code_sub_status   = string #(Optional) The Request Sub Status of the Status Code.
            status_code_win32_status = string #(Optional) The Win32 Status Code of the Request.
          }))
        })
      })

      site_config_cors_enabled = bool #(Optional) Should windows_web_app cross origin resource sharing be enabled.
      cors = object({
        cors_allowed_origins     = list(string) #(Required) Specifies a list of origins that should be allowed to make cross-origin calls.
        cors_support_credentials = bool         #(Optional) Are credentials allowed in CORS requests? Defaults to false.
      })

      ip_restriction_enabled = bool                               #(Optional) should windows web app ip restriction be enabled.
      ip_restriction = map(object({                               ## NOTE:- One and only one of ip_address, service_tag or virtual_network_subnet_id must be specified.
        ip_restriction_action                            = string #(Optional) The action to take. Possible values are Allow or Deny.
        ip_restriction_ip_address                        = string #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        ip_restriction_name                              = string #(Optional) The name which should be used for this ip_restriction.
        ip_restriction_priority                          = string #(Optional) The priority value of this ip_restriction.
        ip_restriction_service_tag                       = string #(Optional) The Service Tag used for this IP Restriction.
        ip_restriction_virtual_network_subnet_id_enabled = bool

        ip_restriction_headers = object({
          ip_restriction_headers_x_azure_fdid      = list(string) #(Optional) Specifies a list of Azure Front Door IDs.
          ip_restriction_headers_x_fd_health_probe = list(string) #(Optional) Specifies if a Front Door Health Probe should be expected.
          ip_restriction_headers_x_forwarded_for   = list(string) #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          ip_restriction_headers_x_forwarded_host  = list(string) #(Optional) Specifies a list of Hosts for which matching should be applied.
        })
      }))

      scm_ip_restriction_enabled = bool #(Optional) should windows web app scm ip restriction be enabled.
      scm_ip_restriction = map(object({
        scm_ip_restriction_action                            = string #(Optional) The action to take. Possible values are Allow or Deny.
        scm_ip_restriction_ip_address                        = string #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        scm_ip_restriction_name                              = string #(Optional) The name which should be used for this ip_restriction.
        scm_ip_restriction_priority                          = string #(Optional) The priority value of this ip_restriction.
        scm_ip_restriction_service_tag                       = string #(Optional) The Service Tag used for this IP Restriction.
        scm_ip_restriction_virtual_network_subnet_id_enabled = bool

        scm_ip_restriction_headers = object({
          scm_ip_restriction_headers_x_azure_fdid      = list(string) #(Optional) Specifies a list of Azure Front Door IDs.
          scm_ip_restriction_headers_x_fd_health_probe = list(string) #(Optional) Specifies if a Front Door Health Probe should be expected.
          scm_ip_restriction_headers_x_forwarded_for   = list(string) #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          scm_ip_restriction_headers_x_forwarded_host  = list(string) #(Optional) Specifies a list of Hosts for which matching should be applied.
        })
      }))

      site_config_virtual_application = map(object({ #Optional) One or more virtual_application blocks as defined below.
        virtual_application_physical_path = string   #(Required) The physical path for the Virtual Application.
        virtual_application_preload       = bool     #(Required) Should pre-loading be enabled. Defaults to false.
        virtual_application_virtual_path  = string   #(Required) The Virtual Path for the Virtual Application.

        virtual_application_virtual_directory = map(object({ #(Optional) One or more virtual_directory blocks as defined below.
          virtual_directory_physical_path = string           #(Optional) The physical path for the Virtual Application.
          virtual_directory_virtual_path  = string           #(Optional) The Virtual Path for the Virtual Application.
        }))

      }))
    })

    windows_web_app_tags = map(string) #(Optional) A mapping of tags which should be assigned to the Windows Web App.
  }))
}