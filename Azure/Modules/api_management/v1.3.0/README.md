### Attributes: ###
- api_management_name                = string #(Required) The name of the API Management Service. Changing this forces a new resource to be created.
- api_management_location            = string #(Required) The Azure location where the API Management Service exists. Changing this forces a new resource to be created.
- api_management_resource_group_name = string #(Required) The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created.
- api_management_publisher_name      = string #(Required) The name of publisher/company.
- api_management_publisher_email     = string #(Required) The email of publisher/company.
- api_management_sku_name            = string #(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).
- api_management_additional_location = list(object({}))                         #(Optional) One or more additional_location blocks as defined below.
   - additional_location_location                              = string       #(Required) The name of the Azure Region in which the API Management Service should be expanded to.
   - additional_location_capacity                              = number       #(Optional) The number of compute units in this region. Defaults to the capacity of the main region.
   - additional_location_zones                                 = list(string) #(Optional) A list of availability zones.
   - additional_location_public_ip_address_name                = string       #(Optional) name of a standard SKU IPv4 Public IP.
   - additional_location_public_ip_address_resource_group_name = string       #(Optional) resource group name of a standard SKU IPv4 Public IP.
   - additional_location_virtual_network_configuration = object({})             #(Optional) A virtual_network_configuration block as defined below. Required when virtual_network_type is External or Internal.
     - virtual_network_configuration_subnet_name                = string      #(Required) The id of the subnet that will be used for the API Management.
     - virtual_network_configuration_virtual_network_name       = string      #(Required) The id of the subnet that will be used for the API Management.
     - virtual_network_configuration_subnet_resource_group_name = string      #(Required) The id of the subnet that will be used for the API Management.
   - additional_location_gateway_disabled = string #(Optional) Only valid for an Api Management service deployed in multiple locations. This can be used to disable the gateway in this additional location.  
- api_management_certificate_key_vault_name                = string #(Optional) Only required if api_management_certificate block is passed. The key vault where Base64 encoded certificate and certificate password is stored
- api_management_certificate_key_vault_resource_group_name = string #(Optional) Only required if api_management_certificate block is passed. The key vault resource group, where Base64 encoded certificate and certificate password is stored
- api_management_certificate = list(object({}))              #(Optional) One or more (up to 10) certificate blocks as defined below.
   - certificate_encoded_certificate_secret_name  = string #(Required) The key vault secret where Base64 Encoded PFX or Base64 Encoded X.509 Certificate is stored. this is referred from api_management_certificate_key_vault_name
   - certificate_store_name                       = string #(Required) The name of the Certificate Store where this certificate should be stored. Possible values are CertificateAuthority and Root.
   - certificate_certificate_password_secret_name = string #(Optional) The key vault secret where password for the certificate is stored. this is referred from api_management_certificate_key_vault_name
- api_management_delegation = object({})
   - delegation_subscriptions_enabled     = bool   #(Optional) Should subscription requests be delegated to an external url? Defaults to false.
   - delegation_user_registration_enabled = bool   #(Optional) Should user registration requests be delegated to an external url? Defaults to false.
   - delegation_url                       = string #(Optional) The delegation URL.
   - delegation_validation_key            = string #(Optional) A base64-encoded validation key to validate, that a request is coming from Azure API Management.
- api_management_client_certificate_enabled = bool         #(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is Consumption.
- api_management_gateway_disabled           = bool         #(Optional) Disable the gateway in main region? This is only supported when additional_location is set.
- api_management_min_api_version            = string       #(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than.
- api_management_zones                      = list(string) #(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created.
- api_management_identity = object({})                  #(Optional) An identity block as defined below.
   - identity_type = string                            #(Required) Specifies the type of Managed Service Identity that should be configured on this API Management Service. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
   - identity_user_assigned_identities = list(object({})) #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this API Management Service. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
     - identity_name                = string      #user assigned identity name Required if identity type ="systemassigned" or "systemassigned,userassigned"
     - identity_resource_group_name = string      #resource group name of the user identity
- api_management_hostname_configuration = object({})                              #(Optional) A hostname_configuration block as defined below.
   - hostname_configuration_key_vault_name                              = string #(Optional) The name of the Key Vault containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
   - hostname_configuration_key_vault_resource_group_name               = string #(Optional) The resource group of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
   - hostname_configuration_ssl_keyvault_identity_client_type           = string #(Optional) Possible values are SystemAssigned, UserAssigned. Pass null if not required
   - hostname_configuration_ssl_keyvault_identity_client_id             = string #(Optional) The client id of the System or User Assigned Managed identity generated by Azure AD, which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
   - hostname_configuration_ssl_keyvault_identity_client_name           = string #(Optional) The User Assigned Managed identity name , which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
   - hostname_configuration_ssl_keyvault_identity_client_resource_group = string #(Optional) The User Assigned Managed identity resource group name , which has GET access to the keyVault containing the SSL certificate. If User Assigned Managed identity is used in this field, please assign User Assigned Managed identity to the azurerm_api_management as well.
   - hostname_configuration_management = list(object({}))                           #(Optional) One or more management blocks as documented below.
     - management_host_name                    = string                          #(Required) The Hostname to use for the Management API.
     - management_key_vault_secret_name        = string                          #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12. Setting this field requires the identity block to be specified, since this identity is used for to retrieve the Key Vault Certificate. Auto-updating the Certificate from the Key Vault requires the Secret version isn't specified.
     - management_negotiate_client_certificate = bool                            #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
   - hostname_configuration_portal = list(object({}))  #(Optional) One or more portal blocks as documented below.
     - portal_host_name                    = string #(Required) The Hostname to use for the Management API.
     - portal_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
     - portal_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
   - hostname_configuration_developer_portal = list(object({}))  #(Optional) One or more developer_portal blocks as documented below.
     - developer_portal_host_name                    = string #(Required) The Hostname to use for the Management API.
     - developer_portal_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
     - developer_portal_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
   - hostname_configuration_proxy = list(object({}))  #(Optional) One or more proxy blocks as documented below.
     - proxy_default_ssl_binding          = bool   #(Optional) Is the certificate associated with this Hostname the Default SSL Certificate? This is used when an SNI header isn't specified by a client. Defaults to false.
     - proxy_host_name                    = string #(Required) The Hostname to use for the Management API.
     - proxy_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
     - proxy_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
   - hostname_configuration_scm = list(object({}))  #(Optional) One or more scm blocks as documented below.
     - scm_host_name                    = string #(Required) The Hostname to use for the Management API.
     - scm_key_vault_secret_name        = string #(Optional) The name of the Key Vault Secret containing the SSL Certificate, which must be should be of the type application/x-pkcs12.
     - scm_negotiate_client_certificate = bool   #(Optional) Should Client Certificate Negotiation be enabled for this Hostname? Defaults to false.
- api_management_notification_sender_email = string #(Optional) Email address from which the notification will be sent.
- api_management_policy = object({}) #(Optional) A policy block as defined below.
   - policy_xml_content = string    #(Optional) The XML Content for this Policy.
   - policy_xml_link    = string    #(Optional) A link to an API Management Policy XML Document, which must be publicly available.
- api_management_protocols = object({}) #(Optional) A protocols block as defined below.
   - protocols_enable_http2 = bool     #(Optional) Should HTTP/2 be supported by the API Management Service? Defaults to false.
- api_management_security = object({})                                    #(Optional) A security block as defined below.
   - security_enable_backend_ssl30                                = bool #(Optional) Should SSL 3.0 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30 field
   - security_enable_backend_tls10                                = bool #(Optional) Should TLS 1.0 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10 field
   - security_enable_backend_tls11                                = bool #(Optional) Should TLS 1.1 be enabled on the backend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11 field
   - security_enable_frontend_ssl30                               = bool #(Optional) Should SSL 3.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30 field
   - security_enable_frontend_tls10                               = bool #(Optional) Should TLS 1.0 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10 field
   - security_enable_frontend_tls11                               = bool #(Optional) Should TLS 1.1 be enabled on the frontend of the gateway? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11 field
   - security_tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = bool #(Optional) Should the TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA field
   - security_tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = bool #(Optional) Should the TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA field
   - security_tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = bool #(Optional) Should the TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA field
   - security_tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = bool #(Optional) Should the TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA field
   - security_tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_128_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA256 field
   - security_tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = bool #(Optional) Should the TLS_RSA_WITH_AES_128_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_CBC_SHA field
   - security_tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_128_GCM_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_128_GCM_SHA256 field
   - security_tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = bool #(Optional) Should the TLS_RSA_WITH_AES_256_CBC_SHA256 cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA256 field
   - security_tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = bool #(Optional) Should the TLS_RSA_WITH_AES_256_CBC_SHA cipher be enabled? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TLS_RSA_WITH_AES_256_CBC_SHA field
   - security_triple_des_ciphers_enabled                          = bool #(Optional) Should the TLS_RSA_WITH_3DES_EDE_CBC_SHA cipher be enabled for alL TLS versions (1.0, 1.1 and 1.2)? Defaults to false. This maps to the Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168 field
- api_management_sign_in = object({}) #(Optional) A sign_in block as defined below.
   - sign_in_enabled = bool          #(Required) Should anonymous users be redirected to the sign in page?
- api_management_sign_up = object({})              #(Optional) A sign_up block as defined below.
   - sign_up_enabled = bool                       #(Required) Can users sign up on the development portal?
   - sign_up_terms_of_service = object({})          #(Required) A terms_of_service block as defined below.
     - terms_of_service_consent_required = bool   #(Required) Should the user be asked for consent during sign up?
     - terms_of_service_enabled          = bool   #(Required) Should Terms of Service be displayed during sign up?.
     - terms_of_service_text             = string #(Required) The Terms of Service which users are required to agree to in order to sign up.
- api_management_tenant_access = object({}) #(Optional) A tenant_access block as defined below.
   - tenant_access_enabled = bool          #(Required) Should the access to the management API be enabled?
- api_management_public_ip_address_name                = string #(Optional) name of a standard SKU IPv4 Public IP.
- api_management_public_ip_address_resource_group_name = string #(Optional) resource group of a standard SKU IPv4 Public IP.
- api_management_public_network_access_enabled         = bool   #(Optional) Is public access to the service allowed?. Defaults to true
- api_management_virtual_network_type                  = string #(Optional) The type of virtual network you want to use, valid values include: None, External, Internal. virtual_network_type is Internal or External. And please ensure other necessary ports are open according to api management network configuration.
- api_management_virtual_network_configuration = object({})             #(Optional) A virtual_network_configuration block as defined below. Required when virtual_network_type is External or Internal.
   - virtual_network_configuration_subnet_name                = string #(Required) The id of the subnet that will be used for the API Management.
   - virtual_network_configuration_virtual_network_name       = string #(Required) The id of the subnet that will be used for the API Management.
   - virtual_network_configuration_subnet_resource_group_name = string #(Required) The id of the subnet that will be used for the API Management.
- api_management_tags = map(string) #(Optional) A mapping of tags assigned to the resource.

### Notes: ###
>1. Premium SKU's are limited to a default maximum of 12 (i.e. Premium_12), this can, however, be increased via support request.
>2. Consumption SKU capacity should be 0 (e.g. Consumption_0) as this tier includes automatic scaling.
>3. Availability zones are only supported in the Premium tier.
>4. Custom public IPs are only supported on the Premium and Developer tiers when deployed in a virtual network.
>5. This option is applicable only to the Management plane, not the API gateway or Developer portal. It is required to be true on the creation.
>6. Availability zones and custom public IPs are only supported in the Premium tier.
>7. Identity ids - This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
>8. key_vault_id - Setting this field requires the identity block to be specified, since this identity is used for to retrieve the Key Vault Certificate. Possible values are versioned or versionless secret ID. Auto-updating the Certificate from the Key Vault requires the Secret version isn't specified.
>9. Either key_vault_id or certificate and certificate_password must be specified.
>10. If a User Assigned Managed identity is specified for ssl_keyvault_identity_client_id then this identity must be associated to the azurerm_api_management within an identity block.
>11. This is commented because this is optional and there is a glitch in terraform v3.75.0 where the value expected for certificate_password is bool instead of a string.  