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

module "ejercicio6_remoto" {
  source = "github.com/stemdo-labs/terraform-exercises-ploopez/soluciones/ejercicio5-ploopez/modules/moduloAntiguo"
  owner_tag = "plopez"
  vnet_address_space = var.vnet_address_space
  environment_tag = "pRE"
  vnet_name = var.vnet_name
  resource_group_name = var.resource_group_name
  vnet_tags = var.vnet_tags
}