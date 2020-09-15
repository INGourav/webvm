resource "azurerm_virtual_network" "vnet" {
  name                = "AzureVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vnetrg.location
  resource_group_name = azurerm_resource_group.vnetrg.name

  tags = {
    environment = "Production"
  }
  
}