#Kubernetes cluster output
output "kubernetes_cluster_output" {
  description = "The Kubernetes cluster output"
  value = { for k, v in azurerm_kubernetes_cluster.kubernetes_cluster : k => {
    id       = v.id
    identity = v.identity
    }
  }
}