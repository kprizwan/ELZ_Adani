#AUTOMATION ACCOUNT VARIABLES
variable "automation_account_variables" {
  type = map(object({
    automation_account_uid_cmk_encryption_name                 = string      # The name of User Assigned Managed Identity ID to be used for accessing the Customer Managed Key for encryption.
    autommation_account_uid_cmk_encryption_resource_group_name = string      # The resource group name of User Assigned Managed Identity ID to be used for accessing the Customer Managed Key for encryption.
    automation_account_key_vault_name                          = string      # The key vault name which will have the key vault key for encryption.
    automation_account_key_vault_resource_group_name           = string      # The key vault resource group name which will have the key vault key for encryption.
    automation_account_key_vault_key_name                      = string      #   The Key Vault Key name which should be used to Encrypt the data in this Automation Account.
    automation_account_name                                    = string      # (Required) Specifies the name of the Automation Account. Changing this forces a new resource to be created.
    automation_account_public_network_access_enabled           = bool        # (Optional) Whether public network access is allowed for the container registry. Defaults to true.)
    automation_account_location                                = string      # (Required) Specifies the supported Azure location where the resource exists.
    automation_account_resource_group_name                     = string      # (Required) The name of the resource group in which the Automation Account is created. 
    automation_account_sku_name                                = string      # (Required) The SKU of the account. Possible values are Basic and Free.
    automation_account_local_authentication_enabled            = bool        # (Optional) Whether requests using non-AAD authentication are blocked.
    automation_account_tags                                    = map(string) # (Optional) A mapping of tags to assign to the resource.
    automation_account_identity = object({                                   # (Optional) Identity Block.
      automation_account_identity_type = string                              # (Required) The type of identity used for this Automation Account. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned.
      automation_account_identity_ids = list(object({                        # identity_ids is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
        user_assigned_identity_name                = string
        user_assigned_identity_resource_group_name = string
      }))
    })
  }))
  description = "Map of Automation Account Variables"
  default     = {}
}