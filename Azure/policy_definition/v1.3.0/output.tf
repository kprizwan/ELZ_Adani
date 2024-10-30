#POLICY DEFINITION OUTPUT
output "policy_definition_output" {
  description = "policy definition output values"
  value = { for k, v in azurerm_policy_definition.policy_definition : k => {
    id                  = v.id
    role_definition_ids = v.role_definition_ids
    }
  }
}