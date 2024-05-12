terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "rg1plopez-lab01"
      storage_account_name = "tfstatebgpkx"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}


resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}


resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.resource_code.result}"
  resource_group_name      = "rg1plopez-lab01"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = "tfstatebgpkx"
  container_access_type = "private"
}

//////////////////////////////////////////////////////

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags = merge(
    var.vnet_tags,
    {
        environment_tag = var.environment_tag
    }
  )
}
//////////////////////////////////////////////////////
