resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.infra.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_contributor" {
  scope                = azurerm_resource_group.infrastructure.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.infra.identity.0.principal_id
}

resource "azurerm_role_assignment" "kubelet_contributor" {
  scope                = azurerm_resource_group.infrastructure.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.infra.kubelet_identity[0].object_id
}