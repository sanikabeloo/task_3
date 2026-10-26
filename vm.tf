
# Network Interface 1
resource "azurerm_network_interface" "task3_web_nic_1" {
  name                = "task3-web-nic-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.task3_web_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Network Interface 2
resource "azurerm_network_interface" "task3_web_nic_2" {
  name                = "task3-web-nic-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.task3_web_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Network Interface 3
resource "azurerm_network_interface" "task3_web_nic_3" {
  name                = "task3-web-nic-3"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.task3_web_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Windows VM 1
resource "azurerm_windows_virtual_machine" "task3_web_vm_1" {
  name                = "task3-web-vm-1"
  computer_name       = "task3webvm1"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.task3_web_nic_1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}

# Windows VM 2
resource "azurerm_windows_virtual_machine" "task3_web_vm_2" {
  name                = "task3-web-vm-2"
  computer_name       = "task3webvm2"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.task3_web_nic_2.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}

# Windows VM 3
resource "azurerm_windows_virtual_machine" "task3_web_vm_3" {
  name                = "task3-web-vm-3"
  computer_name       = "task3webvm3"
  location            = var.location
  resource_group_name = azurerm_resource_group.task3_rg.name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.task3_web_nic_3.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}

# Associate VM 1 NIC with Load Balancer
resource "azurerm_network_interface_backend_address_pool_association" "task3_vm1" {
  network_interface_id    = azurerm_network_interface.task3_web_nic_1.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.task3_backend_pool.id
}

# Associate VM 2 NIC with Load Balancer
resource "azurerm_network_interface_backend_address_pool_association" "task3_vm2" {
  network_interface_id    = azurerm_network_interface.task3_web_nic_2.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.task3_backend_pool.id
}

# Associate VM 3 NIC with Load Balancer
resource "azurerm_network_interface_backend_address_pool_association" "task3_vm3" {
  network_interface_id    = azurerm_network_interface.task3_web_nic_3.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.task3_backend_pool.id
}