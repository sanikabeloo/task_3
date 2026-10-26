
resource "azurerm_public_ip" "task3_lb_public_ip" {
  name                = "task3-lb-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.public_ip_domain_name_label
}

resource "azurerm_lb" "task3_load_balancer" {
  name                = "task3-load-balancer"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "task3-frontend"
    public_ip_address_id = azurerm_public_ip.task3_lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "task3_backend_pool" {
  name            = "task3-backend-pool"
  loadbalancer_id = azurerm_lb.task3_load_balancer.id
}


resource "azurerm_lb_probe" "task3_http_probe" {
  name            = "task3-http-probe"
  loadbalancer_id = azurerm_lb.task3_load_balancer.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}


resource "azurerm_lb_rule" "task3_http_rule" {
  name                           = "task3-http-rule"
  loadbalancer_id                = azurerm_lb.task3_load_balancer.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "task3-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.task3_backend_pool.id]
  probe_id                       = azurerm_lb_probe.task3_http_probe.id
}