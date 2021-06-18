variable "subnet_id_aks" {
    type        = string
    description = "variable para evaluar si es necesario desplegar una subnet, en caso de ya poseer una y pasar su id por esta variable el recurso no se creará"
}

variable "rg_name" {
    description = "Nombre del Resource Group"
}

variable "address_prefixes" {
    description = "cidr de la subnet"
    default     = ["10.0.1.0/24"]
    type        = list(string)
}

variable "vnet_name" {
    description = "Nombre de la VNet"
    type        = string
}

variable "subnet_name" {
    description = "Nombre de la subnet"
}