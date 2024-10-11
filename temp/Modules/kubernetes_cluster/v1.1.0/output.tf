
output "kubernetes_cluster_principle_ids" {
  description = "System Assigned Principal ID"
  value       = { for k, x in azurerm_kubernetes_cluster.kubernetes_cluster : k => [for y in x.identity : y.tenant_id] }
}

output "kubernetes_cluster_ids" {
  value = { for k, x in azurerm_kubernetes_cluster.kubernetes_cluster : k => x.id }
}