resource "azurerm_log_analytics_workspace" "infra" {
  name                = local.log_workspace_name
  location            = azurerm_resource_group.infrastructure.location
  resource_group_name = azurerm_resource_group.infrastructure.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}