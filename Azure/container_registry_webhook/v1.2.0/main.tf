#container_registry_webhook
resource "azurerm_container_registry_webhook" "container_registry_webhook" {
  for_each            = var.container_registry_webhook_variables
  name                = each.value.container_registry_webhook_name
  resource_group_name = each.value.container_registry_webhook_resource_group_name
  registry_name       = each.value.container_registry_webhook_registry_name
  location            = each.value.container_registry_webhook_location
  service_uri         = each.value.container_registry_webhook_service_uri
  actions             = each.value.container_registry_webhook_actions
  status              = each.value.container_registry_webhook_status
  scope               = each.value.container_registry_webhook_scope
  custom_headers      = each.value.container_registry_webhook_custom_headers
  tags                = merge(each.value.container_registry_webhook_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}
