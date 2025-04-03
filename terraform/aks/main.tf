# Configure the Azure Provider
provider "azurerm" {
  features {} # Required block for azurerm provider
  # Assumes Azure CLI login provides authentication
}

# Define Terraform required providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Use a recent version compatible with TF 1.11.3
    }
  }
  required_version = ">= 1.1.0"
}

# Create Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.azure_region

  tags = {
    environment = "CloudWeave"
    project     = "MultiClusterGitOps"
  }
}

# Create Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.cluster_name}-vnet"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    environment = "CloudWeave"
  }
}

# Create Subnet for AKS
resource "azurerm_subnet" "aks" {
  name                 = "${var.cluster_name}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.aks_subnet_address_prefix
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    vnet_subnet_id = azurerm_subnet.aks.id # Associate node pool with the subnet
  }

  # Use System Assigned Identity for simplicity
  identity {
    type = "SystemAssigned"
  }

  # Network Profile - using Kubenet for simplicity, CNI requires more setup
  network_profile {
    network_plugin = "kubenet"
    # service_cidr = "10.2.0.0/24" # Optional: Define if needed
    # dns_service_ip = "10.2.0.10" # Optional: Define if needed
    # docker_bridge_cidr = "172.17.0.1/16" # Optional: Define if needed
  }

  tags = {
    environment = "CloudWeave"
    project     = "MultiClusterGitOps"
  }

  depends_on = [
    azurerm_virtual_network.main,
    azurerm_subnet.aks,
  ]
}