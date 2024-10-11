variable "key_vault_subscription_id" {
  description = "Key Vault Subscription ID. If Key Vault not used provide the same subscription id as aks Subscription id"
  type        = string
}

variable "key_vault_tenant_id" {
  description = "Key Vault Tenant ID. If Key Vault not used provide the same subscription id as aks Tenant id"
  type        = string
}

variable "kubernetes_cluster_subscription_id" {
  description = "AKS Subscription ID."
  type        = string
}

variable "kubernetes_cluster_tenant_id" {
  description = "AKS Subscription ID."
  type        = string
}

variable "log_analytics_oms_subscription_id" {
  description = "Log Analytics for OMS Subscription ID. If Log Analytics for OMS not used provide the same subscription id as aks Subscription id"
  type        = string
}

variable "log_analytics_oms_tenant_id" {
  description = "Log Analytics for OMS Tenant ID. If Log Analytics for OMS not used provide the same subscription id as aks Tenant id"
  type        = string
}

variable "log_analytics_defender_tenant_id" {
  description = "Log Analytics for Microsoft Defender Tenant ID. If Log Analytics for Microsoft Defender not used provide the same subscription id as aks Tenant id"
  type        = string
}
variable "log_analytics_defender_subscription_id" {
  description = "Log Analytics for Microsoft Defender Subscription ID. If Log Analytics for Microsoft Defender not used provide the same subscription id as aks Subscription id"
  type        = string
}
variable "private_dns_zone_subscription_id" {
  description = "Private DNS Zone Subscription ID."
  type        = string
}
variable "private_dns_zone_tenant_id" {
  description = "Private DNS Zone tenant ID."
  type        = string
}
