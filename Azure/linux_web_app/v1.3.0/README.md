## Attributes:

- linux_web_app_name                               = string      #(Required) The name which should be used for this Linux Web App. Changing this forces a new Linux Web App to be created.
- linux_web_app_location                           = string      #(Required) The Azure Region where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
- linux_web_app_resource_group_name                = string      #(Required) The name of the Resource Group where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
- linux_web_app_client_affinity_enabled            = bool        #(Optional) Should Client Affinity be enabled?
- linux_web_app_client_certificate_enabled         = string      #(Optional) Should Client Certificates be enabled?
- linux_web_app_client_certificate_mode            = string      # (Optional) The Client Certificate mode. Possible values are Required, Optional, and OptionalInteractiveUser. This property has no effect when client_certificate_enabled is false
- linux_web_app_client_certificate_exclusion_paths = string      # (Optional) Paths to exclude when using client certificates, separated by ;
- site_config_application_stack_docker_registry_password                     = string      #(Optional) site_config_application_stack_docker_registry_password from data block
- site_config_application_stack_docker_registry_password_resource_group_name = string      #(Optional) site_config_application_stack_docker_registry_password_resource_group_name from data block
- site_config_application_stack_docker_registry_url                          = string      #(Optional) site_config_application_stack_docker_registry_url from data block
- site_config_application_stack_docker_registry_url_resource_group_name      = string      #(Optional) site_config_application_stack_docker_registry_url_resource_group_name from data block
- site_config_application_stack_docker_registry_username                     = string      #(Optional) site_config_application_stack_docker_registry_username from data block
- site_config_application_stack_docker_registry_username_resource_group_name = string      #(Optional) site_config_application_stack_docker_registry_username_resource_group_name from data block
- linux_web_app_app_settings                       = map(string) # (Optional) A map of key-value pairs of App Settings.
- linux_web_app_enabled                            = bool        #Defaults to true
- linux_web_app_https_only                         = bool        #(Optional) Should the Linux Web App require HTTPS connections. 
- linux_web_app_app_settings_enabled               = bool        #(Optional) A auth_settings block as defined below.
- linux_web_app_zip_deploy_file                    = string      # (Optional) The local path and filename of the Zip packaged application to deploy to this Linux Web App.
- linux_web_app_public_network_access_enabled      = string      # Should public network access be enabled for the Web App. Defaults to true.
- key_vault_reference_identity_id                  = string      #(Optional) The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block. For more information see - Access vaults with a user-assigned identit
- linux_web_app_sticky_settings = list(object({                  #(Optional) A sticky_settings block as defined below.
  - sticky_settings_app_setting_names       = string             # (Optional) A list of app_setting names that the Linux Web App will not swap between Slots when a swap operation is triggered.
  - sticky_settings_connection_string_names = string             #(Optional) A list of connection_string names that the Linux Web App will not swap between Slots when a swap operation is triggered.
- linux_web_app_connection_string = list(object({ # block supports the following:
  - connection_string_name  = string              #Required) The name of the Connection String.
  - connection_string_type  = string              # (Required) Type of database. Possible values include: MySQL, SQLServer, SQLAzure, Custom, NotificationHub, ServiceBus, EventHub, APIHub, DocDb, RedisCache, and PostgreSQL.
  - connection_string_value = string              #(Required) The connection string value.
- linux_web_app_storage_account = list(object({ #- (Optional) One or more storage_account blocks as defined below.
  - storage_account_access_key   = string       #(Required) The Access key for the storage account.
  - storage_account_account_name = string       #(Required) The Name of the Storage Account.
  - storage_account_name         = string       #(Required) The Name of the Storage Account.
  - storage_account_share_name   = string       #(Required) The Name of the File Share or Container Name for Blob storage
  - storage_account_type         = string       #(Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob
  - storage_account_mount_path   = string       # (Optional) The path at which to mount the storage share.
- linux_web_app_logs = list(object({      # (Optional) A logs block as defined below.
  - logs_detailed_error_messages = string #(Optional) Should detailed error messages be enabled?
  - logs_failed_request_tracing  = string # (Optional) Should the failed request tracing be enabled?
  - http_logs = list(object({
    - azure_blob_storage = list(object({              # (Optional) A azure_blob_storage block as defined above.
    - azure_blob_storage_retention_in_days = string # (Optional) A file_system block as defined above.
    - file_system = list(object({          #block supports the following:
      - content_retention_in_days = string #(Required) The retention period in days. A value of 0 means no retention.
      - content_retention_in_mb   = string #(Required) The maximum size in megabytes that log files can use.
  - linux_web_app_application_logs = list(object({
    - file_system_level = string                      #Possible values include Error, Warning, Information, Verbose and Off
    - azure_blob_storage = list(object({              #block supports the following:
    - azure_blob_storage_level             = string # (Required) Log level. Possible values include: Verbose, Information, Warning, and Error.
    - azure_blob_storage_retention_in_days = string ##(Required) The retention period in days. A value of 0 means no retention.
- linux_web_app_auth_settings = object({           #block supports the following:    
  - auth_settings_enabled = bool                   # (Required) Should the Authentication / Authorization feature be enabled for the Linux Web App?
  - auth_settings_active_directory = list(object({ # (Optional) # An active_directory block as defined above.
  - client_id                  = string          # (Required) The ID of the Client to use to authenticate with Azure Active Directory.
  - allowed_audiences          = list(string)    # (Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
  - client_secret              = string          # (Optional) The Client Secret for the Client ID. Cannot be used with client_secret_setting_name.
  - client_secret_setting_name = string          # (Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
  - auth_settings_additional_login_parameters    = map(string)  # (Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
  - a_settings_allowed_external_redirect_urls = list(string) # (Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the Linux Web App.
  - a_settings_default_provider               = string       # (Optional) The default authentication provider to use when multiple providers are configured. Possible values include: BuiltInAuthenticationProviderAzureActiveDirectory, BuiltInAuthenticationProviderFacebook, BuiltInAuthenticationProviderGoogle, BuiltInAuthenticationProviderMicrosoftAccount, BuiltInAuthenticationProviderTwitter, BuiltInAuthenticationProviderGithub
  - a_settings_facebook = list(object({                      # (Optional) A facebook block as defined below.
    - app_id                  = string                          # (Required) The App ID of the Facebook app used for login.
    - app_secret              = string                          # (Optional) The App Secret of the Facebook app used for Facebook login. Cannot be specified with app_secret_setting_name.
    - app_secret_setting_name = string                          # (Optional) The app setting name that contains the app_secret value used for Facebook login. Cannot be specified with app_secret.
    - oauth_scopes            = list(string)                    # (Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
  - a_settings_github = list(object({        # (Optional) A github block as defined below.
  - client_id                  = string       # (Required) The ID of the GitHub app used for login.
  - client_secret              = string       # (Optional) The Client Secret of the GitHub app used for GitHub login. Cannot be specified with client_secret_setting_name.
  - client_secret_setting_name = string       # (Optional) The app setting name that contains the client_secret value used for GitHub login. Cannot be specified with client_secret.
    - oauth_scopes               = list(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
  - a_settings_google = list(object({        # (Optional) A google block as defined below.
  - client_id                  = string       # (Required) The OpenID Connect Client ID for the Google web application.
  - client_secret              = string       # (Optional) The client secret associated with the Google web application. Cannot be specified with client_secret_setting_name.
  - client_secret_setting_name = string       # (Optional) The app setting name that contains the client_secret value used for Google login. Cannot be specified with client_secret.
    - oauth_scopes               = list(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, openid, profile, and email are used as default scopes.
  - a_settings_issuer = string               # (Optional) The OpenID Connect Issuer URI that represents the entity that issues access tokens for this Linux Web App.
  - a_settings_microsoft = list(object({     # (Optional) A microsoft block as defined below.
  - client_id                  = string       # (Required) The OAuth 2.0 client ID that was created for the app used for authentication.
  - client_secret              = string       # (Optional) The OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret_setting_name.
  - client_secret_setting_name = string       # (Optional) The app setting name containing the OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret.
    - oauth_scopes               = list(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, "wl.basic" is used as the default scope.
  - a_settings_runtime_version               = string # (Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the Linux Web App.
  - a_settings_token_refresh_extension_hours = number # (Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
  - a_settings_token_store_enabled           = bool   # (Optional) Should the Linux Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
  - a_settings_twitter = list(object({                # (Optional) A twitter block as defined below.
    - consumer_key                 = string              # (Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
    - consumer_secret              = string              # (Optional) The OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret_setting_name.
    - consumer_secret_setting_name = string              # (Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with consumer_secret.
  - a_settings_unauthenticated_client_action = string # (Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
- linux_web_app_auth_settings_v2 = object({                                 #block supports the following:
  - auth_settings_v2_auth_enabled                            = bool         # (Optional) Should the AuthV2 Settings be enabled. Defaults to false.
  - auth_settings_v2_runtime_version                         = string       # (Optional) The Runtime Version of the Authentication and Authorisation feature of this App. Defaults to ~1.
  - auth_settings_v2_config_file_path                        = string       # (Optional) The path to the App Auth settings.
  - auth_settings_v2_require_authentication                  = bool         # (Optional) Should the authentication flow be used for all requests.
  - auth_settings_v2_unauthenticated_action                  = string       # (Optional) The action to take for requests made without authentication. Possible values include RedirectToLoginPage, AllowAnonymous, Return401, and Return403. Defaults to RedirectToLoginPage.
  - auth_settings_v2_default_provider                        = string       # (Optional) The Default Authentication Provider to use when the unauthenticated_action is set to RedirectToLoginPage. Possible values include: apple, azureactivedirectory, facebook, github, google, twitter and the name of your custom_oidc_v2 provider.
  - auth_settings_v2_excluded_paths                          = list(string) # (Optional) The paths which should be excluded from the unauthenticated_action when it is set to RedirectToLoginPage.
  - auth_settings_v2_require_https                           = bool         # (Optional) Should HTTPS be required on connections? Defaults to true.
  - auth_settings_v2_http_route_api_prefix                   = string       # (Optional) The prefix that should precede all the authentication and authorisation paths. Defaults to /.auth.
  - auth_settings_v2_forward_proxy_convention                = string       # (Optional) The convention used to determine the url of the request made. Possible values include ForwardProxyConventionNoProxy, ForwardProxyConventionStandard, ForwardProxyConventionCustom. Defaults to ForwardProxyConventionNoProxy.
  - auth_settings_v2_forward_proxy_custom_host_header_name   = string       # (Optional) The name of the custom header containing the host of the request.
  - auth_settings_v2_forward_proxy_custom_scheme_header_name = string       # (Optional) The name of the custom header containing the scheme of the request.
  - auth_settings_v2_apple_v2 = list(object({                               # (Optional) An apple_v2 block as defined below.
  - client_id                  = string                                   # (Required) The OpenID Connect Client ID for the Apple web application.
  - client_secret_setting_name = string                                   # (Required) The app setting name that contains the client_secret value used for Apple Login.
        login_scopes               = list(string)                             # A list of Login Scopes provided by this Authentication Provider.
  - auth_settings_v2_active_directory_v2 = list(object({  # (Optional) An active_directory_v2 block as defined below.
    - client_id                            = string       # (Required) The ID of the Client to use to authenticate with Azure Active Directory.
        tenant_auth_endpoint                 = string       # (Required) The Azure Tenant Endpoint for the Authenticating Tenant. e.g. https://login.microsoftonline.com/v2.0/{tenant-guid}/
    - client_secret_setting_name           = string       # (Optional) The App Setting name that contains the client secret of the Client.
    - client_secret_certificate_thumbprint = string       # (Optional) The thumbprint of the certificate used for signing purposes.
    - jwt_allowed_groups                   = list(string) # (Optional) A list of Allowed Groups in the JWT Claim.
    - jwt_allowed_client_applications      = list(string) # (Optional) A list of Allowed Client Applications in the JWT Claim.
    - www_authentication_disabled          = bool         # (Optional) Should the www-authenticate provider should be omitted from the request? Defaults to false
    - allowed_groups                       = list(string) # (Optional) The list of allowed Group Names for the Default Authorisation Policy.
    - allowed_identities                   = list(string) # (Optional) The list of allowed Identities for the Default Authorisation Policy.
      - allowed_applications                 = list(string) # (Optional) The list of allowed Applications for the Default Authorisation Policy.
      - login_parameters                     = map(string)  # (Optional) A map of key-value pairs to send to the Authorisation Endpoint when a user logs in.
      - allowed_audiences                    = list(string) # (Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
  - auth_settings_v2_azure_static_web_app_v2 = list(object({ # (Optional) An azure_static_web_app_v2 block as defined below.
    - client_id = string                                     # (Required) The ID of the Client to use to authenticate with Azure Static Web App Authentication.
    - auth_settings_v2_custom_oidc_v2 = list(object({ # (Optional) Zero or more custom_oidc_v2 blocks as defined below.
    - name                          = string        # (Required) The name of the Custom OIDC Authentication Provider.
    - client_id                     = string        # (Required) The ID of the Client to use to authenticate with the Custom OIDC.
    - openid_configuration_endpoint = string        # (Required) Specifies the endpoint used for OpenID Connect Discovery. For example https://example.com/.well-known/openid-configuration.
    - name_claim_type               = string        # (Optional) The name of the claim that contains the users name.
    - scopes                        = list(string)  # (Optional) The list of the scopes that should be requested while authenticating.
    - client_credential_method      = string        # The Client Credential Method used.
    - client_secret_setting_name    = string        # The App Setting name that contains the secret for this Custom OIDC Client. This is generated from name above and suffixed with _PROVIDER_AUTHENTICATION_SECRET.
    - aorisation_endpoint        = string        # The endpoint to make the Authorisation Request as supplied by openid_configuration_endpoint response.
    - token_endpoint                = string        # The endpoint used to request a Token as supplied by openid_configuration_endpoint response.
    - issuer_endpoint               = string        # The endpoint that issued the Token as supplied by openid_configuration_endpoint response.
    - certification_uri             = string        # The endpoint that provides the keys necessary to validate the token as supplied by openid_configuration_endpoint response.
  - auth_settings_v2_facebook_v2 = list(object({ # (Optional) A facebook_v2 block as defined below.
    - app_id                  = string           # (Required) The App ID of the Facebook app used for login.
    - app_secret_setting_name = string           # (Required) The app setting name that contains the app_secret value used for Facebook Login.
    - graph_api_version       = string           # (Optional) The version of the Facebook API to be used while logging in.
    - login_scopes            = list(string)     # (Optional) The list of scopes that should be requested as part of Facebook Login authentication.
    - auth_settings_v2_github_v2 = list(object({  # (Optional) A github_v2 block as defined below.
    - client_id                  = string       # (Required) The ID of the GitHub app used for login..
    - client_secret_setting_name = string       # (Required) The app setting name that contains the client_secret value used for GitHub Login.
    - login_scopes               = list(string) # (Optional) The list of OAuth 2.0 scopes that should be requested as part of GitHub Login authentication.
  - auth_settings_v2_google_v2 = list(object({  # (Optional) A google_v2 block as defined below.
    - client_id                  = string       # (Required) The OpenID Connect Client ID for the Google web application.
    - client_secret_setting_name = string       # (Required) The app setting name that contains the client_secret value used for Google Login.
    - allowed_audiences          = list(string) # (Optional) Specifies a list of Allowed Audiences that should be requested as part of Google Sign-In authentication.
    - login_scopes               = list(string) # (Optional) The list of OAuth 2.0 scopes that should be requested as part of Google Sign-In authentication.
    - auth_settings_v2_microsoft_v2 = list(object({ # (Optional) A microsoft_v2 block as defined below.
    - client_id                  = string         # (Required) The OAuth 2.0 client ID that was created for the app used for authentication.
    - client_secret_setting_name = string         # (Required) The app setting name containing the OAuth 2.0 client secret that was created for the app used for authentication.
    - allowed_audiences          = list(string)   # (Optional) Specifies a list of Allowed Audiences that will be requested as part of Microsoft Sign-In authentication.
    - login_scopes               = list(string)   # (Optional) The list of Login scopes that should be requested as part of Microsoft Account authentication.    
  - auth_settings_v2_twitter_v2 = list(object({ # (Optional) A twitter_v2 block as defined below.
    - consumer_key                 = string     # (Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
    - consumer_secret_setting_name = string     # (Required) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in.
    - auth_settings_v2_login = list(object({             # (Optional) A login block as defined below.
      - logout_endpoint                   = string       # (Optional) The endpoint to which logout requests should be made.
      - token_store_enabled               = bool         # (Optional) Should the Token Store configuration Enabled. Defaults to false
      - token_refresh_extension_time      = number       # (Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.
      - token_store_path                  = string       # (Optional) The directory path in the App Filesystem in which the tokens will be stored.
      - token_store_sas_setting_name      = string       # (Optional) The name of the app setting which contains the SAS URL of the blob storage containing the tokens.
      - preserve_url_fragments_for_logins = bool         # (Optional) Should the fragments from the request be preserved after the login request is made. Defaults to false.
      - allowed_external_redirect_urls    = list(string) # (Optional) External URLs that can be redirected to as part of logging in or logging out of the app. This is an advanced setting typically only needed by Windows Store application backends.
      - cookie_expiration_convention      = string       # (Optional) The method by which cookies expire. Possible values include: FixedTime, and IdentityProviderDerived. Defaults to FixedTime.
      - cookie_expiration_time            = string       # (Optional) The time after the request is made when the session cookie should expire. Defaults to 08:00:00.
      - validate_nonce                    = bool         # (Optional) Should the nonce be validated while completing the login flow. Defaults to true.
      - nonce_expiration_time             = string       # (Optional) The time after the request is made when the nonce should expire. Defaults to 00:05:00.
- linux_web_app_backup = list(object({
  - backup_name                  = string              # (Required) The name which should be used for this Backup.
  - linux_web_app_backup_enabled = string              #(Optional) Should this backup job be enabled?
    - schedule = list(object({                           #(Required) A schedule block as defined below.
      - backup_schedule_frequency_interval      = string #(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day).
      - backup_schedule_frequency_unit          = string # (Required) The unit of time for how often the backup should take place. Possible values include: Day, Hour
      - backup_schedule_retention_period_days   = string #(Optional) After how many days backups should be deleted. 
      - backup_schedule_start_time              = string #(Optional) When the schedule should start working in RFC-3339 format.
      - backup_schedule_keep_atleast_one_backup = string # (Optional) Should the service keep at least one backup, regardless of the age of backup? Defaults to false.
- linux_web_app_identity = object({                        #(Optional) An identity block as defined below. 
  - linux_web_app_identity_type = string                   # (Required) Specifies the type of Managed Service Identity that should be configured on this Linux Web App. Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned (to enable both).
  - linux_web_app_user_assigned_identities = list(object({ #(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Linux Web App.
    - user_identity_name                = string           #(Optional) if linux web app user assigned identities vlaues are passed then name of the user_identity_name should be provided
    - user_identity_resource_group_name = string           #(Optional) if linux web app user assigned identities vlaues are passed then name of the user_identity_name resource group should be provided
- linux_web_app_site_config = list(object({                                  #(Required) A site_config block as defined below.
    - site_config_always_on                                     = bool         # (Optional) If this Linux Web App is Always On enabled. Defaults to true.
    - site_config_api_definition_url                            = string       # (Optional) The URL to the API Definition for this Linux Web App.
    - site_config_api_management_api_id                         = string       #(Optional) The API Management API ID this Linux Web App is associated with.
    - site_config_ftps_state                                    = string       # (Optional) The State of FTP / FTPS service. Possible values include AllAllowed, FtpsOnly, and Disabled.
    - site_config_app_command_line                              = string       # (Optional) The App command line to launch.
    - site_config_health_check_path                             = string       # (Optional) The path to the Health Check.
    - site_config_health_check_eviction_time_in_min             = string       # (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
    - site_config_http2_enabled                                 = bool         # (Optional) Should the HTTP2 be enabled?
    - auto_heal_enabled                                         = bool         #(Optional) Should Auto heal rules be enabled? Required with auto_heal_setting.
    - local_mysql_enabled                                       = bool         # (Optional) Use Local MySQL. Defaults to false.
    - websockets_enabled                                        = bool         # (Optional) Should Web Sockets be enabled? Defaults to false.
    - vnet_route_all_enabled                                    = bool         #(Optional) Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
    - scm_minimum_tls_version                                   = string       #Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
    - scm_use_main_ip_restriction                               = string       #  (Optional) One or more ip_restriction blocks as defined above.
    - site_config_use_32_bit_worker                             = string       #(Optional) Should the Linux Web App use a 32-bit worker? Defaults to true.
    - site_config_default_documents                             = list(string) # (Optional) Specifies a list of Default Documents for the Linux Web App.
    - site_config_load_balancing_mode                           = string       # (Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
    - site_config_managed_pipeline_mode                         = string       # (Optional) Managed pipeline mode. Possible values include Integrated, and Classic.
    - site_config_minimum_tls_version                           = string       # (Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
    - site_config_remote_debugging_enabled                      = bool         #(Optional) Should Remote Debugging be enabled? Defaults to false.
    - site_config_remote_debugging_version                      = string       # (Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019
    - site_config_worker_count                                  = string       # (Optional) The number of Workers for this Linux App Service.
    - site_config_container_registry_managed_identity_client_id = string       # (Optional) The Client ID of the Managed Service Identity to use for connections to the Azure Container Registry.
    - site_config_container_registry_use_managed_identity       = string       #(Optional) Should connections for Azure Container Registry use Managed Identity.
    - site_config_cors = list(object({                                         #block supports the following:
      - site_config_cors_allowed_origins     = string                          #(Required) Specifies a list of origins that should be allowed to make cross-origin calls.
      - site_config_cors_support_credentials = string                          # (Optional) Whether CORS requests with credentials are allowed. Defaults to false
      - site_config_ip_restriction = list(object({
        - ip_restriction_action                    = string #(Optional) The action to take. Possible values are Allow or Deny.
        - ip_restriction_service_tag               = string #(Optional) The Service Tag used for this IP Restriction.
        - ip_restriction_name                      = string #(Optional) The name which should be used for this ip_restriction.
        - ip_restriction_priority                  = string # (Optional) The priority value of this ip_restriction.
        - ip_restriction_ip_address                = string #(Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        - ip_restriction_virtual_network_subnet_id = string #(Optional) The Virtual Network Subnet ID used for this IP Restriction.
        - ip_restriction_headers = list(object({            #(Optional) A headers block as defined above.
          - headers_x_azure_fdid      = string              # (Optional) Specifies a list of Azure Front Door IDs.
          - headers_x_fd_health_probe = string              #(Optional) Specifies if a Front Door Health Probe should be expected.
          - headers_x_forwarded_for   = string              #(Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          - headers_x_forwarded_host  = string              # (Optional) Specifies a list of Hosts for which matching should be applied.
      - site_config_scm_ip_restriction = list(object({          # block supports the following:
        - scm_ip_restriction_action                    = string # (Optional) The action to take. Possible values are Allow or Deny.
        - scm_ip_restriction_service_tag               = string # (Optional) The Service Tag used for this IP Restriction.
        - scm_ip_restriction_name                      = string #(Optional) The name which should be used for this ip_restriction.
        - scm_ip_restriction_priority                  = string #(Optional) The priority value of this ip_restriction.
        - scm_ip_restriction_ip_address                = string # (Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
        - scm_ip_restriction_virtual_network_subnet_id = string #(Optional) The Virtual Network Subnet ID used for this IP Restriction.
        - scm_ip_restriction_headers = list(object({            #(Optional) A headers block as defined above.
          - headers_x_azure_fdid      = string                  # (Optional) Specifies a list of Azure Front Door IDs.
          - headers_x_fd_health_probe = string                  #(Optional) Specifies if a Front Door Health Probe should be expected.
          - headers_x_forwarded_for   = string                  # (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
          - headers_x_forwarded_host  = string                  #(Optional) Specifies a list of Hosts for which matching should be applied.
      - site_config_application_stack = list(object({                #block supports the following:
        - site_config_application_stack_docker_image        = string #(Optional) The Docker image reference, including repository host as needed.
        - site_config_application_stack_docker_image_tag    = string # (Optional) The image Tag to use. e.g. latest.
        - site_config_application_stack_go_version          = string # (Optional) The version of Go to use. Possible values include 1.18, and 1.19.
        - site_config_application_stack_dotnet_version      = string # (Optional) The version of .NET to use. Possible values include 3.1, 5.0, 6.0 and 7.0.
        - site_config_application_stack_java_server         = string # (Optional) The Java server type. Possible values include JAVA, TOMCAT, and JBOSSEAP.
        - site_config_application_stack_java_server_version = string # (Optional) The Version of the java_server to use.
        - site_config_application_stack_java_version        = string #(Optional) The Version of Java to use. Supported versions of Java vary depending on the java_server and java_server_version, as well as security and fixes to major versions. Please see Azure documentation for the latest information.
        - site_config_application_stack_node_version        = string #Possible values include 12-lts, 14-lts, and 16-lts. This property conflicts with java_version.
        - site_config_application_stack_php_version         = string #Possible values include 7.4, and 8.0.
        - site_config_application_stack_python_version      = string #Possible values include 3.7, 3.8, and 3.9.
        - site_config_application_stack_ruby_version        = string # Possible values include 2.6 and 2.7.
        - site_config_auto_heal_setting = list(object({
          - auto_heal_setting_action = list(object({         #(Optional) A action block as defined above.
            - action_action_type                    = string # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle.
            - action_minimum_process_execution_time = string #(Optional) The minimum amount of time in hh:mm:ss the Linux Web App must have been running before the defined action will be run in the event of a trigger.
          - auto_heal_setting_trigger = list(object({ #(Optional) A trigger block as defined below.
            - trigger_requests = list(object({        #block supports the following:
              - requests_count    = string            #(Required) The number of requests in the specified interval to trigger this rule.
              - requests_interval = string            #(Required) The interval in hh:mm:ss.
            - trigger_slow_request = list(object({ # block supports the following:
              - slow_request_count      = string   #(Required) The number of Slow Requests in the time interval to trigger this rule.
              - slow_request_interval   = string   #(Required) The time interval in the form hh:mm:ss.
              - slow_request_time_taken = string   # (Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
              - slow_request_path       = string   #(Optional) The path for which this slow request rule applies.
           - trigger_status_code = list(object({      #block supports the following:
             - status_code_count             = string #(Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
             - status_code_interval          = string #(Required) The time interval in the form hh:mm:ss.
             - status_code_status_code_range = string #(Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
             - status_code_path              = string #(Optional) The path to which this rule status code applies.
             - status_code_sub_status        = string # (Optional) The Request Sub Status of the Status Code.
             - status_code_win32_status_code = string #(Optional) The Win32 Status Code of the Request.
- linux_web_app_subnet_required                = bool   #(Optional) if subnet is required then pass the value has true and provide the value for the below.
- linux_web_app_virtual_network_name           = string #(Optional) if subnet is passed true then we need virtual network name for the subnet.
- linux_web_app_subnet_name                    = string #(Optional) if subnet required true then pass the subnet name
- linux_web_app_subnet_resource_group_name     = string #(Optional) if subnet required true then resource group name should be provided.
- key_vault_name                               = string #(optional) key valut name should be provided for key_vault_reference_identity_id
- key_vault_resource_group_name                = string #(optional) key valut resource group name should be provided for key_vault_reference_identity_id
- service_plan_name                            = string #(Required) The name of the Service Plan that this Linux App Service will be created in for the service plan id .
- service_plan_resource_group_name             = string #(Required) The service plan resource group name  that this Linux App Service will be created in for the service plan id .
- linux_web_app_storage_account_required       = bool   #(Optional) storage account is required pass true value
- user_storage_account_name                    = string #(Optional) if storage account name is provided true than storage account name should be provided
- storage_account_resource_group_name          = string #(optional) if storage account resource group name is provided true than storage account name should be provided 
- linux_web_app_storage_account_sas_start_time = string #(optional) storage account sas start time should be pass here
- linux_web_app_storage_account_sas_end_time   = string #(optional) storage account sas end time should be pass here
- linux_web_app_tags                           = map(string)
## Notes :

> 1.Terraform will perform a name availability check as part of the creation progress, if this Web App is part of an App Service Environment terraform will require Read permission on the ASE for this to complete reliably.
> 2.The AzureRM Terraform provider provides regional virtual network integration via the standalone resource app_service_virtual_network_swift_connection and in-line within this resource using the virtual_network_subnet_id property. You cannot use both methods simultaneously. If the virtual network is set via the resource app_service_virtual_network_swift_connection then ignore_changes should be used in the web app configuration.
> 3.Assigning the virtual_network_subnet_id property requires RBAC permissions on the subnet.
> 4.Using this value requires WEBSITE_RUN_FROM_PACKAGE=1 to be set on the App in app_settings. Refer to the Azure docs for further details.
> 5.The client_id value is always considered an allowed audience.
> 6.docker_registry_url, docker_registry_username, and docker_registry_password replace the use of the app_settings values of DOCKER_REGISTRY_SERVER_URL, DOCKER_REGISTRY_SERVER_USERNAME and DOCKER_REGISTRY_SERVER_PASSWORD respectively, these values will be managed by the provider and should not be specified in the app_settings map.
> 7.JBOSSEAP requires a Premium Service Plan SKU to be a valid option.
> 8.The valid version combinations for java_version, java_server and java_server_version can be checked from the command line via az webapp list-runtimes --linux.
> 9.10.x versions have been/are being deprecated so may cease to work for new resources in the future and may be removed from the provider.
> 10.version 7.4 is deprecated and will be removed from the provider in a future version.
> 11.This setting is only needed if multiple providers are configured, and the unauthenticated_client_action is set to "RedirectToLoginPage".
> 12.When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/.
> 13.Relative Paths are evaluated from the Site Root directory.
> 14.Whilst any value will be accepted by the API for default_provider, it can leave the app in an unusable state if this value does not correspond to the name of a known provider (either built-in value, or custom_oidc name) as it is used to build the auth endpoint URI.
> 15.This list should be used instead of setting WEBSITE_WARMUP_PATH in app_settings as it takes priority.
> 16.A setting with this name must exist in app_settings to function correctly.
> 17.This is configured on the Authentication Provider side and is Read Only here.
> 18.One of client_secret_setting_name or client_secret_certificate_thumbprint must be specified.
> 19.An app_setting matching this value in upper case with the suffix of _PROVIDER_AUTHENTICATION_SECRET is required. e.g. MYOIDC_PROVIDER_AUTHENTICATION_SECRET for a value of myoidc.
> 20.URLs within the current domain are always implicitly allowed.
> 21.Please see the official Azure Documentation for details on using header filtering.
> 22.This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
> 23.One and only one of ip_address, service_tag or virtual_network_subnet_id must be specified.
> 24.Not all intervals are supported on all Linux Web App SKUs. Please refer to the official documentation for appropriate values.
> 25.always_on must be explicitly set to false when using Free, F1, D1, or Shared Service Plans.
> 26.Azure defaults this value to AllAllowed, however, in the interests of security Terraform will default this to Disabled to ensure the user makes a conscious choice to enable it.
> 27.You can access the Principal ID via azurerm_linux_web_app.example.identity.0.principal_id and the Tenant ID via azurerm_linux_web_app.example.identity.0.tenant_id.
