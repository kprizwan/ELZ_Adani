#windows webapp output
output "windows_web_app_output" {
  value = { for k, v in azurerm_windows_web_app.windows_web_app : k => {
    id = v.id
    }
  }
  description = "Windows Web App Output Values"
}