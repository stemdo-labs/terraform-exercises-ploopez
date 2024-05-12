Para el ejercicio 3 he aañadido una serie de campos en el terraform.tfvars

owner_tag = "plopez"
environment_tag = "dev"
vnet_tags = {
  "Department" = "IT"
}

en variables.tf igual, siguiendo als indicaciones del ejercicio :

variable "owner_tag" {
  description = "Propietario de la VNet"
  type        = string
}

variable "environment_tag" {
  description = "Entorno de la VNet (dev, test, prod, etc)"
  type        = string
}

variable "vnet_tags" {
  description = "Tags adicionales para la VNet"
  type        = map(string)
  default     = {}
}


y en main.tf
en el resource de la vnet he tenido que añadir unos cambios en relacion con los elementos añadidos en el ejercicio3 :

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
