# Stage Subscription Medium

#RESOURCE GROUP
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "sd-common-dev-hrgpt-rg" #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = "Central India"             #(Required) The Azure Region where the Resource Group should exist.
    #(Optional) A mapping of tags which should be assigned to the Resource Group.
    resource_group_managed_by = null #(optional)  The ID of the resource or application that manages this Resource Group.
    resource_group_tags = {
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  }
}

#CONTAINER REGISTRY
container_registry_variables = {
  "container_registry_1" = {
    container_registry_name                          = "sddevadaniaesl"     #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-common-dev-hrgpt-rg" # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Standard"              # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true                   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = null                   # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true                   # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false                  # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false                  # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false                  # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy = {
      retention_policy_days    = 7    # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_trust_policy = { # (Optional) Set to null if it is not required.
      trust_policy_enabled = false      #  (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_georeplication_enabled     = false #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications            = null
    container_registry_data_endpoint_enabled      = false           # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.
    container_registry_network_rule_bypass_option = "AzureServices" # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.
    container_registry_encryption = {
      encryption_enabled                      = false #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_keyvault_name                = null  # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = null  # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = null  #(Required) # Resource group of the KeyVault
      encryption_identity_name                = null  # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = null  # (Required) The name of resource group where identity is created.
    }
    container_registry_identity                 = null
    container_registry_network_rule_set_enabled = false #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = {
      network_rule_set_default_action  = null #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule         = null
      network_rule_set_virtual_network = null
    }
    container_registry_tags = { # (Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
  "container_registry_2" = {
    container_registry_name                          = "sddevadanitapregistry"     #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-common-dev-hrgpt-rg" # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Standard"              # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true                   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = null                   # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true                   # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false                  # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false                  # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false                  # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy = {
      retention_policy_days    = 7    # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_trust_policy = { # (Optional) Set to null if it is not required.
      trust_policy_enabled = false      #  (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_georeplication_enabled     = false #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications            = null
    container_registry_data_endpoint_enabled      = false           # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.
    container_registry_network_rule_bypass_option = "AzureServices" # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.
    container_registry_encryption = {
      encryption_enabled                      = false #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_keyvault_name                = null  # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = null  # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = null  #(Required) # Resource group of the KeyVault
      encryption_identity_name                = null  # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = null  # (Required) The name of resource group where identity is created.
    }
    container_registry_identity                 = null
    container_registry_network_rule_set_enabled = false #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = {
      network_rule_set_default_action  = null #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule         = null
      network_rule_set_virtual_network = null
    }
    container_registry_tags = { # (Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
  },
    "container_registry_3" = {
    container_registry_name                          = "sddevsteelbot"     #(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    container_registry_location                      = "Central India"        # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    container_registry_resource_group_name           = "sd-common-dev-hrgpt-rg" # (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    container_registry_sku                           = "Standard"              # (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium.
    container_registry_admin_enabled                 = true                   # (Optional) Specifies whether the admin user is enabled. Defaults to false.
    container_registry_export_policy_enabled         = null                   # (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false.
    container_registry_public_network_access_enabled = true                   # (Optional) Whether public network access is allowed for the container registry. Defaults to true.
    container_registry_quarantine_policy_enabled     = false                  # (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false.
    container_registry_zone_redundancy_enabled       = false                  # (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false.
    container_registry_anonymous_pull_enabled        = false                  # (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU.
    container_registry_retention_policy = {
      retention_policy_days    = 7    # (Optional) The number of days to retain an untagged manifest after which it gets purged. Default is 7.
      retention_policy_enabled = true # (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_trust_policy = { # (Optional) Set to null if it is not required.
      trust_policy_enabled = false      #  (Optional) Boolean value that indicates whether the policy is enabled.
    }
    container_registry_georeplication_enabled     = false #(Required) Whether georeplications should be enabled for the container registry.If the this is true, Provide values to georeplications block
    container_registry_georeplications            = null
    container_registry_data_endpoint_enabled      = false           # (Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU.
    container_registry_network_rule_bypass_option = "AzureServices" # (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices.
    container_registry_encryption = {
      encryption_enabled                      = false #  (Required) Boolean value that indicates whether encryption is enabled. Set to false, if customer managed encryption is not required.
      encryption_keyvault_name                = null  # (Required)The name of the KeyVault where key is stored
      encryption_keyvault_key_name            = null  # (Required) # The name of the keyvault key name
      encryption_keyvault_resource_group_name = null  #(Required) # Resource group of the KeyVault
      encryption_identity_name                = null  # (Required) The Name of the managed identity
      encryption_identity_resource_group_name = null  # (Required) The name of resource group where identity is created.
    }
    container_registry_identity                 = null
    container_registry_network_rule_set_enabled = false #(Required) Whether network rule set to be enabled for the container registry. if the value is true, Provide values to container_registry_network_rule_set block.
    container_registry_network_rule_set = {
      network_rule_set_default_action  = null #  (Optional) The behaviour for requests matching no rules. Either Allow or Deny. Defaults to Allow
      network_rule_set_ip_rule         = null
      network_rule_set_virtual_network = null
    }
    container_registry_tags = { # (Optional) A mapping of tags to assign to the resource.
      BU             = "ELZ",
      Role           = "Dev",
      Environment    = "PLZ-Dev",
      Owner          = "Manish Kumar",
      Criticality    = "Medium",
      Classification = "Gold",
      IAC            = "Terraform",
      Contact        = "Manish.kumar10@adani.com"
    }
}
}
