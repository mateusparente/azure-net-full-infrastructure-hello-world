resource "azurerm_public_ip" "apim" {
  name                 = local.api_management_service_public_ip_name
  location             = azurerm_resource_group.infrastructure.location
  resource_group_name  = azurerm_resource_group.infrastructure.name
  allocation_method    = "Static"
  sku                  = "Standard"
  domain_name_label    = local.api_management_service_public_ip_name
  tags                 = local.tags
}

resource "azurerm_api_management" "infra" {
  name                 = local.api_management_service_name
  location             = azurerm_resource_group.infrastructure.location
  resource_group_name  = azurerm_resource_group.infrastructure.name
  publisher_name       = var.apim_publisher_name
  publisher_email      = var.apim_publisher_email
  sku_name             = "Developer_1"
  public_ip_address_id = azurerm_public_ip.apim.id
  tags                 = local.tags
  identity {
    type = "SystemAssigned"
  }
  virtual_network_type = "External"
  virtual_network_configuration {
    subnet_id = azurerm_subnet.apim.id
  }

  depends_on = [ 
    azurerm_subnet_network_security_group_association.apim_gateway 
  ]
}

resource "azurerm_api_management_custom_domain" "sandbox" {
  api_management_id = azurerm_api_management.infra.id
  gateway {
    host_name    = local.apim_custom_gateway_domain
    key_vault_id = data.azurerm_key_vault_certificate.sandbox.versionless_secret_id
  }
  developer_portal {
    host_name    = local.apim_custom_developer_domain
    key_vault_id = data.azurerm_key_vault_certificate.sandbox.versionless_secret_id
  }
  depends_on = [ azurerm_key_vault_access_policy.apim_certificate_access ]
}