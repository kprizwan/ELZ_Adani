#LOGIC APP STANDARD OUTPUT
output "logic_app_standard_outputs" {
  value = { for k, v in azurerm_logic_app_standard.logic_app_standard : k => {
    id = v.id
    }
  }
  description = "logic app standard outputs values"
}