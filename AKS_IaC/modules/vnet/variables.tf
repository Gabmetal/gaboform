variable "subnet_id_aks" {
    type        = string
    description = "variable para evaluar si es necesario desplegar una vnet, en caso de ya poseer una y pasar su id por esta variable el recurso no se creará"
}

variable "vnet_name" {
    description = "Nombre para la vnet"
}

variable "rg_name" {
    description = "Nombre del Resource Group"
    type        = string
}

variable "location" {
    description = "Location donde se levantan los Recursos"
}

variable "address_space" {
    description = "Rango de IP de la VNet"
    type        = list(string)
    default     = ["10.0.0.0/16"]
}

variable "tags" {
    type        = map(string)
    description = "Tags"
    default     = {}
}