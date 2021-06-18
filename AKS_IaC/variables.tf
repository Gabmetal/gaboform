############## UPDATING EXISTING CLUSTER?? ##############
variable "updating_existing_cluster" {
  description = "Se está actualizando un cluster existente?"
  type        = bool
  default     = false
}

# Si poseemos alguna llave ssh la deberíamos pasar aqui o con la variable de entorno TF_VAR_ssh_key
variable "ssh_key" {
  description = "Llave SSH"
  default     = ""
}

### Resource Group variables
variable "location" {
  description = "Locacion de azure"
  default     = "eastus2"
}

variable "rg_name" {
  description = "Nombre del grupo de recursos en el que desea desplegar los recursos del clúster"
  type        = string
  default     = "aks-test-rg"
}

variable "tags" {
  description = "tags para los recursos"
  type        = map(string)
  default = {
    environment = "develop"
    application = "test"
  }
}

### Azure container registry variables
variable "create_new_acr" {
  description = "Se va a crear un ACR nuevo?"
  type        = bool
  default     = true
}

variable "acrname" {
  description = "Nombre ACR"
  default     = "testacr001"
  type        = string
}

variable "enable_attach_acr" {
  description = "attach acr to cluster? (true/false)"
  type        = bool
  default     = true
}

### Cluster Service Principal variables
variable "end_date_relative" {
  type        = string
  description = "Tiempo relativo hasta el vencimiento de las credenciales ej: 8760h (1 año)"
  default     = "8760h"
}

### Vnet variables
variable "vnet_name" {
  description = "Nombre para la vnet"
  type        = string
  default     = "aks-vnet"
}

variable "address_space" {
  description = "Rango de IP de la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

## Subnet Variables
variable "subnet_name" {
  description = "Nombre de la subnet"
  type        = string
  default     = "aks-subnet"
}

variable "address_prefixes" {
  description = "cidr de la subnet"
  default     = ["10.0.1.0/24"]
  type        = list(string)
}

### AKS Cluster variables
variable "existing_sp_id" {
  type        = string
  description = "Si tenemos un service principal ya creado para asignar al cluster debemos pasar su app_id aquí"
  default     = ""
}

variable "existing_sp_password" {
  type        = string
  description = "Si tenemos un service principal ya creado para asignar al cluster debemos pasar su password aquí"
  default     = ""
}

variable "aks_name" {
  description = "Nombre del AKS"
  default     = "testaks-01"
  type        = string
}

variable "dns_prefix" {
  description = ""
  default     = "testaks-01"
}

variable "vmsizecluster" {
  description = "Tamaño cluster"
  default     = "standard_a2_v2"
  type        = string
}

variable "kubernetes_version" {
  description = "Indica version de Kubernetes"
  default     = "1.18.17"
  type        = string
}

variable "subnet_id_aks" {
  description = "ID Subnet AKS"
  default     = ""
  type        = string
}

variable "node_count" {
  type        = number
  description = "Cantidad de nodos disponibles"
  default     = 1
}

variable "max_count" {
  type        = number
  description = "Cantidad maxima de nodos a escalar"
  default     = 2
}

variable "min_count" {
  type        = number
  description = "Cantidad minima de nodos a escalar"
  default     = 1
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
  default     = "172.17.0.1/16"
}

######### Service Account and Cluster Role Binding variables ##########
variable "sa_name" {
  type        = string
  description = "Name of the service account, must be unique. Cannot be updated."
}

variable "api_group" {
  type        = string
  description = "The API group to drive authorization decisions. This value must be and defaults to rbac.authorization.k8s.io"
  default     = "rbac.authorization.k8s.io"
}

variable "binding_kind" {
  type        = string
  description = "The type of binding to use. This value must be and defaults to ClusterRole"
  default     = "ClusterRole"
}

variable "role_name" {
  type        = string
  description = "The name of this ClusterRole to bind Subjects to."
  default     = "cluster-admin"
}

variable "subject_kind" {
  type        = string
  description = "The type of binding to use. This value must be ServiceAccount, User or Group"
  default     = "ServiceAccount"
}

variable "subject_namespace" {
  type        = string
  description = "Namespace defines the namespace of the ServiceAccount to bind to. This value only applies to kind ServiceAccount"
  default     = "kube-system"
}


######### HELM VARIABLES ###########
variable "namespace" {
  type        = string
  description = "The namespace to install the release into"
}

variable "name" {
  description = "Release name"
}

variable "repository" {
  description = "Repository URL where to locate the requested chart"
}

variable "chart_name" {
  description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified"
}

variable "charts_version" {
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
  default     = ""
}