locals {
  app_service_environment_exists    = { for k, v in var.app_service_plan_variables : k => v if lookup(v, "app_service_environment_name", null) != null }
  app_service_environment_v3_exists = { for k, v in var.app_service_plan_variables : k => v if lookup(v, "app_service_environment_v3_name", null) != null }
}

data "azurerm_app_service_environment_v3" "app_service_environment_v3" {
  for_each            = local.app_service_environment_v3_exists
  name                = each.value.app_service_environment_v3_name
  resource_group_name = each.value.app_service_environment_v3_resource_group_name
}
data "azurerm_app_service_environment" "app_service_environment" {
  for_each            = local.app_service_environment_exists
  name                = each.value.app_service_environment_name
  resource_group_name = each.value.app_service_environment_resource_group_name
}

# Service Plan -->  Manages an App Service.
resource "azurerm_service_plan" "app_service_plan" {
  for_each                     = var.app_service_plan_variables
  name                         = each.value.app_service_plan_name
  location                     = each.value.app_service_plan_location
  os_type                      = each.value.app_service_plan_os_type
  resource_group_name          = each.value.app_service_plan_resource_group_name
  sku_name                     = each.value.app_service_plan_sku_name
  app_service_environment_id   = each.value.app_service_environment_v3_name != null ? data.azurerm_app_service_environment_v3.app_service_environment_v3[each.key].id : each.value.app_service_environment_name != null ? data.azurerm_app_service_environment.app_service_environment[each.key].id : null
  maximum_elastic_worker_count = each.value.app_service_plan_maximum_elastic_worker_count
  worker_count                 = each.value.app_service_plan_worker_count
  per_site_scaling_enabled     = each.value.app_service_plan_per_site_scaling_enabled
  zone_balancing_enabled       = each.value.app_service_plan_zone_balancing_enabled
  tags                         = merge(each.value.app_service_plan_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}