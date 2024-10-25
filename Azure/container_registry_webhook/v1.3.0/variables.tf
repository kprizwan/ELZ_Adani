#CONTAINER REGISTRY WEBHOOK VARIABLES
variable "container_registry_webhook_variables" {
  description = "Map of object container registry webhook variables"
  type = map(object({
    container_registry_webhook_name                = string      #(Required) Specifies the name of the Container Registry Webhook. Only Alphanumeric characters allowed
    container_registry_webhook_resource_group_name = string      #(Required) The name of the resource group in which to create the Container Registry Webhook
    container_registry_webhook_registry_name       = string      #(Required) The Name of Container registry this Webhook belongs to. Changing this forces a new resource to be created
    container_registry_webhook_location            = string      #(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created
    container_registry_webhook_service_uri         = string      #(Required) Specifies the service URI for the Webhook to post notifications
    container_registry_webhook_actions             = set(string) #(Required) A list of actions that trigger the Webhook to post notifications. At least one action needs to be specified. Valid values are: push, delete, quarantine, chart_push, chart_delete
    container_registry_webhook_status              = string      #(Optional) Specifies if this Webhook triggers notifications or not. Valid values: enabled and disabled. Default is enabled
    container_registry_webhook_scope               = string      #(Optional) Specifies the scope of repositories that can trigger an event. For example, foo:* means events for all tags under repository foo. foo:bar means events for 'foo:bar' only. foo is equivalent to foo:latest. Empty means all events
    container_registry_webhook_custom_headers      = map(string) #(Optional) Custom headers that will be added to the webhook notifications request
    container_registry_webhook_tags                = map(string) #(Optional) A mapping of tags to assign to the resource
  }))
  default = {}
}
