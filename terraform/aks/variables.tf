variable "azure_region" {
  description = "Azure region for the AKS cluster"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "cloudweave-rg"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "cloudweave-aks"
}

variable "node_vm_size" {
  description = "VM size for the AKS worker nodes (Low-cost B-series)"
  type        = string
  default     = "Standard_B2s" # Changed to a lower-cost, potentially free-tier eligible size
}

variable "node_count" {
  description = "Number of worker nodes in the AKS cluster"
  type        = number
  default     = 2
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "Address prefix for the AKS subnet"
  type        = list(string)
  default     = ["10.1.0.0/24"]
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "cloudweaveaks" # Must be unique within the Azure region
}