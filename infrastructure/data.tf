data "azurerm_container_registry" "acr" {
    provider = azurerm.operations
    name                     = "mateusparente"
    resource_group_name      = local.operations_rg_name
}