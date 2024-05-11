terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.102.0"
    }
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}


resource "azurerm_subnet" "subnets" {
  depends_on = [azurerm_virtual_network.vnet]
  for_each = var.subnets
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

# resource "azurerm_subnet" "subnet2" {
#   name                 = var.subnet2["subnet2"].name
#   resource_group_name  = var.subnet2["subnet2"].resource_group_name
#   virtual_network_name = var.subnet2["subnet2"].virtual_network_name
#   address_prefixes     = var.subnet2["subnet2"].address_prefixes
#   depends_on = [azurerm_virtual_network.vnet]
# }


resource "azurerm_network_interface" "netint" {
  for_each = var.network_interface
  name                = "${each.key}-netint"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = azurerm_subnet.subnets["subnet1"].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  for_each = var.linux_virtual_machine

  computer_name = each.value.computer_name
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = var.location
  size                = each.value.size
  admin_username      = "adminuser"
  admin_password      = "A1b#c2"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.netint[each.key].id]
  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}

resource "azurerm_lb" "load_balancer" {
  name = var.load_balancer.name
  location = var.location
  resource_group_name = var.resource_group_name
  sku = var.load_balancer.sku

  frontend_ip_configuration {
    name = var.load_balancer.frontend_ip_configuration.name
    subnet_id = azurerm_subnet.subnets["subnet1"].id
    private_ip_address_allocation = var.load_balancer.frontend_ip_configuration.private_ip_address_allocation
  }
}

resource "azurerm_lb_backend_address_pool" "load_balancer_backend_address_pool" {
  loadbalancer_id      = azurerm_lb.load_balancer.id
  name                 = var.load_balancer.backend_address_pool.name
}

resource "azurerm_network_interface_backend_address_pool_association" "association" {
  for_each = azurerm_network_interface.netint

  network_interface_id    = each.value.id
  ip_configuration_name   = each.value.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.load_balancer_backend_address_pool.id
}
