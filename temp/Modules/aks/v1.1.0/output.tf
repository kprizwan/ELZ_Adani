
output "aks_principle_id" {
  description = "System Assigned Principal ID"
  value       = { for k, x in azurerm_kubernetes_cluster.aks_cluster : k => [for y in x.identity : y.tenant_id] }
}

output "managed_cluster_id" {
  value = { for k, x in azurerm_kubernetes_cluster.aks_cluster : k => x.id }
}