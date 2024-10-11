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

variable "user_assigned_identity_subscription_id" {
  description = "User Assigned Identity Subscription ID."
  type        = string
}
variable "user_assigned_identity_tenant_id" {
  description = "User Assigned Identity tenant ID."
  type        = string
}
variable "ingress_application_gateway_subscription_id" {
  description = "Application gateway Subscription ID."
  type        = string
}
variable "ingress_application_gateway_tenant_id" {
  description = "Application gateway tenant ID."
  type        = string
}