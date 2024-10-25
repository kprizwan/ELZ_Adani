#APP SERVICE PLAN

locals {
  app_service_environment_exists = { for k, v in var.app_service_plan_variables : k => v if lookup(v, "app_service_environment_required", false) == true }
}

data "azurerm_app_service_environment" "app_service_environment" {
  for_each            = local.app_service_environment_exists
  name                = each.value.app_service_environment_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_app_service_plan" "app_service_plan" {
  for_each                     = var.app_service_plan_variables
  name                         = each.value.name
  location                     = each.value.location
  resource_group_name          = each.value.resource_group_name
  kind                         = each.value.kind
  maximum_elastic_worker_count = each.value.maximum_elastic_worker_count
  reserved                     = each.value.reserved == "Linux" ? true : false
  app_service_environment_id   = each.value.app_service_environment_required == false ? null : data.azurerm_app_service_environment.app_service_environment[each.key].id
  sku {
    tier     = each.value.sku_tier
    size     = each.value.sku_size
    capacity = each.value.sku_capacity
  }
  per_site_scaling = each.value.per_site_scaling

  tags = merge(each.value.app_service_plan_tags, tomap({ Created_Time = formatdate("DD-MM-YYYY hh:mm:ss ZZZ", timestamp()) }))
  lifecycle { ignore_changes = [tags["Created_Time"]] }
}




