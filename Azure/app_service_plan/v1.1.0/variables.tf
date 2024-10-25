#APP SERVICE PLAN VARIABLE
variable "app_service_plan_variables" {
  type = map(object({
    name                             = string
    resource_group_name              = string
    location                         = string
    os_type                          = string
    maximum_elastic_worker_count     = number
    worker_count                     = number
    app_service_environment_required = bool
    app_service_environment_name     = string
    sku_name                         = string /*The SKU for the app service plan.Possible values include B1,B2,B3,D1,F1,FREE,I1,I2,I3,I1v2,I2v2,I3v2,P1v2,P2v2,P3v2,
    P1v3,P2v3,P3v3,S1,S2,S3,SHARED,EP1,EP2,EP3,WS1,WS2,WS3.
    Note: Isolated SKUs (I1,I2,I3,I1v2,I2v2,and I3v2) can only be used with App Service Environments.
    Note: Elastic and Consumption SKUs(Y1,EP1,EP2,and EP3) are for use with Function Apps.
    Note: F1,B1,B2,B3 can only be used for Dev/Test less demanding workloads.
    Note: P1v2,P2v2,P3v2,P1v3,P2v3,P3v3,S1,S2,S3 can only be used for most production workloads.*/
    per_site_scaling_enabled         = bool
    zone_balancing_enabled           = bool
    app_service_plan_tags            = map(string)
  }))
}