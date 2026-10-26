
resource "azurerm_resource_group" "task3_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "task3_vnet" {
  name                = "task3-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
}

resource "azurerm_subnet" "task3_web_subnet" {
  name                 = "task3-web-subnet"
  resource_group_name  = azurerm_resource_group.task3_rg.name
  virtual_network_name = azurerm_virtual_network.task3_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "task3_app_subnet" {
  name                 = "task3-app-subnet"
  resource_group_name  = azurerm_resource_group.task3_rg.name
  virtual_network_name = azurerm_virtual_network.task3_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "task3_db_subnet" {
  name                 = "task3-db-subnet"
  resource_group_name  = azurerm_resource_group.task3_rg.name
  virtual_network_name = azurerm_virtual_network.task3_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_security_group" "task3_web_nsg" {
  name                = "task3-web-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-rdp"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "task3_app_nsg" {
  name                = "task3-app-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
}

resource "azurerm_network_security_group" "task3_db_nsg" {
  name                = "task3-db-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
}

resource "azurerm_subnet_network_security_group_association" "task3_web_nsg_association" {
  subnet_id                 = azurerm_subnet.task3_web_subnet.id
  network_security_group_id = azurerm_network_security_group.task3_web_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "task3_app_nsg_association" {
  subnet_id                 = azurerm_subnet.task3_app_subnet.id
  network_security_group_id = azurerm_network_security_group.task3_app_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "task3_db_nsg_association" {
  subnet_id                 = azurerm_subnet.task3_db_subnet.id
  network_security_group_id = azurerm_network_security_group.task3_db_nsg.id
}