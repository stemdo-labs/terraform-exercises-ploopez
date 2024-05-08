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

module "security_group" {
  source = "./modules/security_group"
  resource_group_name = "rg1plopez-lab01"
  location            = "West Europe"
}

module "vnet_module" {
  source              = "./modules/vnet_module"
  owner_tag = "plopez"
  vnet_address_space  = var.vnet_address_space
  environment_tag = "pRE"
  vnet_name = var.vnet_name
  resource_group_name = var.resource_group_name
  vnet_tags = var.vnet_tags

}

module "subredes" {
  source = "./modules/subredes"
  for_each = toset(["1", "2"])
  resource_group_name  = "rg1plopez-lab01"
  subnet_address_prefix = ["10.0.${each.key}.0/24"]
  vnet_name = module.vnet_module.name
  subnet_name = each.value
}

# resource "azurerm_subnet_network_security_group_association" "nsg_association" {
#   for_each = toset(values(module.subredes.subnet_ids))
  
#   subnet_id                 = each.value
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }