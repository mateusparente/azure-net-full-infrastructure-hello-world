terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.92.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.26.0"
    }
  }
}

provider "azurerm" {
  features{
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

locals {
    location                    = "UK South"
    infra_name_prefix           = "${var.environment}-infrastructure"
    infra_resource_group_name   = "${local.infra_name_prefix}-rg"
    aks_cluster_name            = "${local.infra_name_prefix}-aks"
    api_management_service_name = "${var.environment}-sandbox-mateusparente-apim"
}

variable "environment" {
  default = "dev"
}

variable "release_number" {
  default = "latest"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_cluster_name
  resource_group_name = local.infra_resource_group_name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  username               = data.azurerm_kubernetes_cluster.aks.kube_config.0.username
  password               = data.azurerm_kubernetes_cluster.aks.kube_config.0.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}