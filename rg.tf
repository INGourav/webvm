resource "azurerm_resource_group" "rg" {
  name     = "uks-prd-rsg-webapp"
  location = "West Europe"
}

resource "azurerm_resource_group" "vnetrg" {
  name     = "uks-prd-rsg-webnet"
  location = "West Europe"
}