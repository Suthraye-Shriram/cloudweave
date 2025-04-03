output "cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.name
}

output "resource_group_name" {
  description = "The name of the resource group containing the AKS cluster."
  value       = azurerm_resource_group.main.name
}

output "kube_config_raw" {
  description = "Raw Kubernetes configuration for the AKS cluster. Use 'az aks get-credentials' for easier integration."
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true # Mark as sensitive as it contains credentials
}

output "cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.id
}

output "location" {
  description = "The Azure region where the cluster is deployed."
  value       = azurerm_resource_group.main.location
}