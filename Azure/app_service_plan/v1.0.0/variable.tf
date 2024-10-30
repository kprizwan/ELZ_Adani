#APP SERVICE PLAN VARIABLE
variable "app_service_plan_variables" {
  type = map(object({
    name                             = string
    resource_group_name              = string
    location                         = string
    kind                             = string
    maximum_elastic_worker_count     = number
    reserved                         = bool
    app_service_environment_required = bool
    app_service_environment_name     = string
    sku_tier                         = string
    sku_size                         = string
    sku_capacity                     = number
    per_site_scaling                 = bool
    app_service_plan_tags            = map(string)
  }))
}
