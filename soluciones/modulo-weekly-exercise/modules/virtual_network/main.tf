terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.102.0"
    }
  }
}

provider "azurerm" {
  features {}
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

# resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
#   computer_name = var.linux_virtual_machine["linux_vm1"].computer_name
#   name                = var.linux_virtual_machine["linux_vm1"].name
#   resource_group_name = var.linux_virtual_machine["linux_vm1"].resource_group_name
#   location            = var.location
#   size                = var.linux_virtual_machine["linux_vm1"].size
#   admin_username      = "adminuser"
#   admin_password      = "A1b#c2"
#   disable_password_authentication = false
#   network_interface_ids = [azurerm_network_interface.netint["subnet1"].id]

#   os_disk {
#     caching              = var.linux_virtual_machine["linux_vm1"].os_disk.caching
#     storage_account_type = var.linux_virtual_machine["linux_vm1"].os_disk.storage_account_type
#   }

#   source_image_reference {
#     publisher = var.linux_virtual_machine["linux_vm1"].source_image_reference.publisher
#     offer     = var.linux_virtual_machine["linux_vm1"].source_image_reference.offer
#     sku       = var.linux_virtual_machine["linux_vm1"].source_image_reference.sku
#     version   = var.linux_virtual_machine["linux_vm1"].source_image_reference.version
#   }
# }

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
