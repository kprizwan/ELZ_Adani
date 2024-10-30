resource "azurerm_application_insights" "appinsight" {
  for_each            = var.application_insights_variables
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  application_type    = each.value.application_type
  retention_in_days   = each.value.retention_in_days
  disable_ip_masking  = each.value.disable_ip_masking
  tags                = merge(each.value.application_insights_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}