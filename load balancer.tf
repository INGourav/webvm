resource "azurerm_lb" "ilb" {
  name                = "lb001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "lb001-feip"
    public_ip_address_id = azurerm_public_ip.pip.id
    
  }


 tags = {
    environment = "Production"
  }
}

resource "azurerm_lb_backend_address_pool" "loadbalancer_backend" {
  name                = "backendaddresspool"
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.ilb.id
}


resource "azurerm_lb_probe" "loadbalancer_prob_80" {
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.ilb.id
  name                = "lbport80probe"
  protocol            = "tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}


resource "azurerm_lb_rule" "lb_80_rul" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.ilb.id
  name                           = "lbrule-80"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 80
  frontend_ip_configuration_name = "lb001-feip"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer_backend.id
  probe_id                       = azurerm_lb_probe.loadbalancer_prob_80.id
}

