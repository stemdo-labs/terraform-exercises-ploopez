variable "resource_group_name" {
  description = "Nombre del Resource Group existente en Azure"
}

variable "vnet_name" {
  description = "Nombre de la Virtual Network a crear"
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la Virtual Network"
  type        = list(string)
}

variable "location" {
  description = "Ubicación donde se desplegará la VNet"
  default     = "West Europe"
}

variable "vnet_tags" {
  description = "Tags adicionales para la VNet"
  type        = map(string)
  default     = {}
}