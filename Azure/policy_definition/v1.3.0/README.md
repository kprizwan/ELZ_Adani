### Attributes: ###
- policy_definition_name                          = string #(Required) The name of the policy definition. Changing this forces a new resource to be created.
- policy_definition_policy_type                   = string # (Required) The policy type. Possible values are BuiltIn, Custom, NotSpecified and Static. Changing this forces a new resource to be created.
- policy_definition_mode                          = string #(Required) The policy resource manager mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data.
- policy_definition_display_name                  = string #(Required) The display name of the policy definition.
- policy_definition_description                   = string # (Optional) The description of the policy definition.
- policy_definition_management_group_display_name = string # (Optional) The display name of the Management Group where this policy should be defined.
- policy_definition_policy_rule                   = string #(Optional) The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block.
- policy_definition_metadata                      = string #(Optional) The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition.
- policy_definition_parameters                    = string #(Optional) Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition.

## Notes ##
>1. These resource provider modes only support built-in policy definitions but may later become available in custom definitions : Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data