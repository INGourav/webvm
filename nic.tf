resource "azurerm_network_interface" "nic" {
   name                          = "AzureTestVM1-NIC"
   location                      = azurerm_resource_group.rg.location
   resource_group_name           = azurerm_resource_group.rg.name
  

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface_backend_address_pool_association" "niclb" {
  network_interface_id    = azurerm_network_interface.nic.id
  ip_configuration_name   = "lbconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.loadbalancer_backend.id
}