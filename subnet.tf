resource "azurerm_subnet" "websubnet" {
  name                 = "AzureWebSubnet"
  resource_group_name  = azurerm_resource_group.vnetrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.0.0/24"
}