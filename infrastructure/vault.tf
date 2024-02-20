data "azurerm_key_vault" "operations_management" {
    provider            = azurerm.operations
    name                = local.operations_vault_name
    resource_group_name = local.operations_rg_name
}

resource "azurerm_key_vault_access_policy" "current_access" {
  key_vault_id = data.azurerm_key_vault.operations_management.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
  certificate_permissions = [
      "Get",
      "List"
  ]
}

resource "azurerm_key_vault_access_policy" "apim_certificate_access" {
  key_vault_id = data.azurerm_key_vault.operations_management.id
  tenant_id    = azurerm_api_management.infra.identity[0].tenant_id
  object_id    = azurerm_api_management.infra.identity[0].principal_id
  key_permissions = [ "Get" ]
  secret_permissions = [ "Get" ]
  certificate_permissions = [ "Get" ]
}

data "azurerm_key_vault_certificate" "sandbox" {
  name         = "mateusparente"
  key_vault_id = data.azurerm_key_vault.operations_management.id
}