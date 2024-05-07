variable "resource_group_name"{
  type = string
}

variable "vnet_name" {

  description = "Nombre de la VNet"
  type        = string
  validation {
    condition     = length(var.vnet_name) > 0 && can(regex("^vnet[a-z]{2,}tfexercise\\d{2,}$", var.vnet_name))
    error_message = "vnet_name no puede estar vacío debe comenzar con 'vnet', seguido de al menos dos caracteres en el rango [a-z], seguido de 'tfexercise', y terminar con al menos dos dígitos numéricos."
  }
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
  validation {
    condition = can(var.vnet_tags) && length(keys(var.vnet_tags)) > 0 && alltrue([for k, v in var.vnet_tags : length(k) > 0 && length(v) > 0])
    error_message = "vnet_tags no puede ser nulo y ninguno de los valores del mapa puede ser una cadena vacía"
  }
}