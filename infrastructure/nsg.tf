resource "azurerm_network_security_group" "gateway" {
  name                = local.security_group_name
  location            = azurerm_resource_group.infrastructure.location
  resource_group_name = azurerm_resource_group.infrastructure.name
}

resource "azurerm_network_security_rule" "AllowHttpsFromInternet" {
  name                        = "AllowHttpsFromInternet"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443"]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "VirtualNetwork"
  description                 = "Client communication to API Management"
  resource_group_name         = azurerm_resource_group.infrastructure.name
  network_security_group_name = azurerm_network_security_group.gateway.name
}

resource "azurerm_network_security_rule" "AllowTagCustom3443Inbound" {
  name                        = "AllowTagCustom3443Inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3443"
  source_address_prefix       = "ApiManagement"
  destination_address_prefix  = "VirtualNetwork"
  description                 = "Management endpoint for Azure portal and PowerShell"
  resource_group_name         = azurerm_resource_group.infrastructure.name
  network_security_group_name = azurerm_network_security_group.gateway.name
}

resource "azurerm_network_security_rule" "AllowTagCustom6390Inbound" {
  name                        = "AllowTagCustom6390Inbound"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6390"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "VirtualNetwork"
  description                 = "Azure Infrastructure Load Balancer"
  resource_group_name         = azurerm_resource_group.infrastructure.name
  network_security_group_name = azurerm_network_security_group.gateway.name
}

resource "azurerm_subnet_network_security_group_association" "apim_gateway" {
  subnet_id                 = azurerm_subnet.apim.id
  network_security_group_id = azurerm_network_security_group.gateway.id
}