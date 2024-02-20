resource "azurerm_virtual_network" "infra" {
  name                = local.vnet_name
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.infrastructure.location
  resource_group_name = azurerm_resource_group.infrastructure.name
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.infrastructure.name
  virtual_network_name = azurerm_virtual_network.infra.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "default_node_pool" {
  name                 = "default-node-pool"
  resource_group_name  = azurerm_resource_group.infrastructure.name
  virtual_network_name = azurerm_virtual_network.infra.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "apim" {
  name                 = "apim-snet"
  resource_group_name  = azurerm_resource_group.infrastructure.name
  virtual_network_name = azurerm_virtual_network.infra.name
  address_prefixes     = ["10.0.3.0/24"]
}