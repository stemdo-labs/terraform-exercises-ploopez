resource_group_name = "rg1plopez-lab01"
vnet_name = "vnetplopeztfexercise01"
vnet_address_space = ["10.0.0.0/16"]
location = "West Europe"

subnets = {
  "subnet1" = {
    name                 = "subnet1"
    resource_group_name  = "rg1plopez-lab01"
    virtual_network_name = "vnetplopeztfexercise01"
    address_prefixes     = ["10.0.1.0/24"]
  }
}

# subnet2 = {
#   "subnet2" = {
#     name                 = "subnet2"
#     resource_group_name  = "rg1plopez-lab01"
#     virtual_network_name = "vnetplopeztfexercise01"
#     address_prefixes     = ["10.0.2.0/24"]
#     }
# }

network_interface = {
  "linux_vm1" = {
    ip_configuration = {
      name                          = "ipconfig1"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = null
    }
  },
  "linux_vm2" = {
    ip_configuration = {
      name                          = "ipconfig2"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = null
    }
  }
}


linux_virtual_machine = {
  "linux_vm1" = {
    computer_name       = "Linux1"
    name                = "linux_vm1"
    resource_group_name = "rg1plopez-lab01"
    location            = "West Europe"
    size                = "Standard_F2"
    admin_username      = "adminuser"
    admin_password      = "A1b#c2"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  },
    "linux_vm2" = {
        computer_name       = "Linux2"
        name                = "linux_vm2"
        resource_group_name = "rg1plopez-lab01"
        location            = "West Europe"
        size                = "Standard_F2"
        admin_username      = "adminuser"
        admin_password      = "A1b#c2"
        os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        }
        source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
        }
    }
}

load_balancer = {
  name                 = "lb1"
  sku                  = "Standard"
  resource_group_name  = "rg1plopez-lab01"
  location             = "West Europe"
  frontend_ip_configuration = {
    name                           = "frontend_ip_configuration"
    private_ip_address_allocation  = "Dynamic"
    public_ip_address_id           = "public_ip_address_id"
  }
  backend_address_pool = {
    name             = "backend_pool_name"
    load_balancer_id = "load_balancer_id"
  }
  backend_address_pool = {
    name             = "backend_pool_name"
    load_balancer_id = "load_balancer_id"
  }
}