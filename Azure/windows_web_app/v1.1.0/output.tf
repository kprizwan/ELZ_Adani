output "windows_web_app_output" {
  description = "windows web app output values"
  value = [
    for k, v in azurerm_windows_web_app.windows_web_app :
    {
      id               = azurerm_windows_web_app.windows_web_app[k].id
      default_hostname = azurerm_windows_web_app.windows_web_app[k].default_hostname
      identity         = azurerm_windows_web_app.windows_web_app[k].identity
      kind             = azurerm_windows_web_app.windows_web_app[k].kind
    }
  ]
}