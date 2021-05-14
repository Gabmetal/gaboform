variable "subnet_id" {
    type        = string
    description = "Id de subnet donde crear la NIC"
}

variable "private_ips" {
    type        = list(string)
    description = "Lista de ip privadas a asignar a la NIC"
}

variable "security_groups_id" {
    type        = list(string)
    description = "Lista de security groups"
}