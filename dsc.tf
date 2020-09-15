resource "azurerm_automation_account" "automation" {
  name                = "account1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name = "Basic"
  }
}

resource "azurerm_automation_dsc_configuration" "dsc" {
  name                    = "ngnix"
  resource_group_name     = azurerm_resource_group.rg.name
  automation_account_name = azurerm_automation_account.automation.name
  location                = azurerm_resource_group.rg.location
  content_embedded        = filebase64(.//WebsiteNgnix.ps1)
}