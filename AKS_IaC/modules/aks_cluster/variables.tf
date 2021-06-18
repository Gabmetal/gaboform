## Se definen las variables para el recurso Azure Kubernetes cluster ##

variable "serviceprincipal_id" {
    description = ""
}

variable "serviceprincipal_key" {
    description = ""
}

variable "ssh_key" {
    description = ""
}

variable "location" {
    description = ""
}

variable "kubernetes_version" {
    description = ""
}

variable "rg_name" {
    description = ""
}

variable "aks_name" {
    description = ""
}

variable "dns_prefix" {
    description = ""
}

variable "vmsizecluster" {
    description = ""
}

variable "vnet_subnet" {
    description = ""
}

variable "node_count" {
    type = number
    description = "Cantidad de nodos disponibles"
}

variable "max_count" {
    type = number
    description = "Cantidad maxima de nodos a escalar"
}

variable "min_count" {
    type = number
    description = "Cantidad minima de nodos a escalar"
}

variable "tags" {
    description = "tags para los recursos"
    type = map(string)
    default = {
        environment = "develop"
        application = "test"
    }
}

variable "pod_cidr" {
    type        = string
    description = "cidr para los pods"
    default     = "10.244.0.0/16"
}

variable "dns_service_ip" {
    type        = string
    description = "ip del servidor dns (debe terminar en .10)"
    default     = "10.0.0.10"
}

variable "service_cidr" {
    type        = string
    description = "cidr para los svc de kubernetes"
    default     = "10.0.0.0/16"
}

variable "docker_bridge_cidr" {
    type        = string
    description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
}