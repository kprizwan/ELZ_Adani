#MANAGEMENT GROUP
management_group_variables = {
  "management_group01" = {
    management_group_name                         = "ploceusmg000001" #(Optional) The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided.
    management_group_parent_management_group_name = null              #(Optional) The ID of the Parent Management Group.Incase of parent define as null
    management_group_subscription_id              = []                #(Optional) A list of Subscription GUIDs which should be assigned to the Management Group.
    management_group_level_number                 = 1                 #(Optional) Level number of the Management Group
  }
}

# POLICY DEFINITION
policy_definition_variables = {
  "policy_definition_1" = {
    policy_definition_name                          = "Restrict_location_for_westus"                               # The name of the policy definition. Changing this forces a new resource to be created.
    policy_definition_policy_type                   = "Custom"                                                     # The policy type. Possible values are BuiltIn, Custom, NotSpecified and Static. Changing this forces a new resource to be created.
    policy_definition_mode                          = "All"                                                        # The policy mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data.
    policy_definition_display_name                  = "restrict_location"                                          # The display name of the policy definition.
    policy_definition_description                   = "Restrict location that its allowed to create resources in." #The description of the policy definition.
    policy_definition_management_group_display_name = null                                                         # The display name of the Management Group where this policy should be defined. Changing this forces a new resource to be created.
    #The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition.
    policy_definition_metadata = <<METADATA
          {
            "category": "General"
          }
        METADATA
    # The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block.
    policy_definition_policy_rule = <<POLICY_RULE
          {
            "if": {
              "not": {
                "field": "location",
                "in": "[parameters('allowedLocations')]"
              }
            },
            "then": {
              "effect": "audit"
            }
          }
        POLICY_RULE
    #  Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition.
    policy_definition_parameters = <<PARAMETERS
          {
            "allowedLocations": {
              "type": "Array",
              "metadata": {
                "description": "The list of allowed locations for resources.",
                "displayName": "Allowed locations",
                "strongType": "location"
              },
              "defaultValue": ["westus"]
            }
          }
        PARAMETERS
  }
}