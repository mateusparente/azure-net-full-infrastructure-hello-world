resource "azurerm_kubernetes_cluster" "infra" {
  name                = local.aks_cluster_name
  location            = azurerm_resource_group.infrastructure.location
  resource_group_name = azurerm_resource_group.infrastructure.name
  dns_prefix          = "${var.environment}${var.dns_prefix}"
  automatic_channel_upgrade = "patch"
  sku_tier            = "Free"
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
    dns_service_ip = "10.0.2.10"
    service_cidr = "10.0.2.0/24"
  }
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
    vnet_subnet_id = azurerm_subnet.default_node_pool.id
    enable_node_public_ip = false
  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.infra.id
  }
  tags = local.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "infra" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.infra.id
  vm_size               = "Standard_D2s_v3"
  node_count            = 1
  tags                  = local.tags
  vnet_subnet_id        = azurerm_subnet.default_node_pool.id
}