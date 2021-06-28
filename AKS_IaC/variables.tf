############## UPDATING EXISTING CLUSTER?? ##############
variable "UPDATING_EXISTING_CLUSTER" {
  description = "Se está actualizando un cluster existente?"
  type        = bool
  default     = false
}

# Si poseemos alguna llave ssh la deberíamos pasar aqui o con la variable de entorno TF_VAR_ssh_key
variable "SSH_KEY" {
  description = "Llave SSH"
  default     = ""
}

### Resource Group variables
variable "LOCATION" {
  description = "Locacion de azure"
  default     = "eastus2"
}

variable "RG_NAME" {
  description = "Nombre del grupo de recursos en el que desea desplegar los recursos del clúster"
  type        = string
  default     = "aks-test-rg"
}

variable "TAGS" {
  description = "TAGS para los recursos"
  type        = map(string)
  default = {
    environment = "develop"
    application = "test"
  }
}

### Azure container registry variables
variable "CREATE_NEW_ACR" {
  description = "Se va a crear un ACR nuevo?"
  type        = bool
  default     = true
}

variable "ACRNAME" {
  description = "Nombre ACR"
  default     = "testacr001"
  type        = string
}

variable "ENABLE_ATTACH_ACR" {
  description = "attach acr to cluster? (true/false)"
  type        = bool
  default     = true
}

### Cluster Service Principal variables
variable "END_DATE_RELATIVE" {
  type        = string
  description = "Tiempo relativo hasta el vencimiento de las credenciales ej: 8760h (1 año)"
  default     = "8760h"
}

### Vnet variables
variable "VNET_NAME" {
  description = "Nombre para la vnet"
  type        = string
  default     = "aks-vnet"
}

variable "ADDRESS_SPACE" {
  description = "Rango de IP de la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

## Subnet Variables
variable "SUBNET_NAME" {
  description = "Nombre de la subnet"
  type        = string
  default     = "aks-subnet"
}

variable "ADDRESS_PREFIXES" {
  description = "cidr de la subnet"
  default     = ["10.0.1.0/24"]
  type        = list(string)
}

### AKS Cluster variables
variable "EXISTING_SP_ID" {
  type        = string
  description = "Si tenemos un service principal ya creado para asignar al cluster debemos pasar su app_id aquí"
  default     = ""
}

variable "EXISTING_SP_PASSWORD" {
  type        = string
  description = "Si tenemos un service principal ya creado para asignar al cluster debemos pasar su password aquí"
  default     = ""
}

variable "AKS_NAME" {
  description = "Nombre del AKS"
  default     = "testaks-01"
  type        = string
}

variable "DNS_PREFIX" {
  description = ""
  default     = "testaks-01"
}

variable "VMSIZECLUSTER" {
  description = "Tamaño cluster"
  default     = "standard_a2_v2"
  type        = string
}

variable "KUBERNETES_VERSION" {
  description = "Indica version de Kubernetes"
  default     = "1.18.17"
  type        = string
}

variable "SUBNET_ID_AKS" {
  description = "ID Subnet AKS"
  default     = ""
  type        = string
}

variable "NODE_COUNT" {
  type        = number
  description = "Cantidad de nodos disponibles"
  default     = 1
}

variable "MAX_COUNT" {
  type        = number
  description = "Cantidad maxima de nodos a escalar"
  default     = 2
}

variable "MIN_COUNT" {
  type        = number
  description = "Cantidad minima de nodos a escalar"
  default     = 1
}

variable "POD_CIDR" {
  type        = string
  description = "cidr para los pods"
  default     = "10.244.0.0/16"
}

variable "DNS_SERVICE_IP" {
  type        = string
  description = "ip del servidor dns (debe terminar en .10)"
  default     = "10.0.0.10"
}

variable "SERVICE_CIDR" {
  type        = string
  description = "cidr para los svc de kubernetes"
  default     = "10.0.0.0/16"
}

variable "DOCKER_BRIDGE_CIDR" {
  type        = string
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
  default     = "172.17.0.1/16"
}

######### Service Account and Cluster Role Binding variables ##########
variable "SA_NAME" {
  type        = string
  description = "NAME of the service account, must be unique. Cannot be updated."
}

variable "API_GROUP" {
  type        = string
  description = "The API group to drive authorization decisions. This value must be and defaults to rbac.authorization.k8s.io"
  default     = "rbac.authorization.k8s.io"
}

variable "BINDING_KIND" {
  type        = string
  description = "The type of binding to use. This value must be and defaults to ClusterRole"
  default     = "ClusterRole"
}

variable "ROLE_NAME" {
  type        = string
  description = "The NAME of this ClusterRole to bind Subjects to."
  default     = "cluster-admin"
}

variable "SUBJECT_KIND" {
  type        = string
  description = "The type of binding to use. This value must be ServiceAccount, User or Group"
  default     = "ServiceAccount"
}

variable "SUBJECT_NAMESPACE" {
  type        = string
  description = "NAMESPACE defines the NAMESPACE of the ServiceAccount to bind to. This value only applies to kind ServiceAccount"
  default     = "kube-system"
}


######### HELM VARIABLES ###########
variable "NAMESPACE" {
  type        = string
  description = "The NAMESPACE to install the release into"
}

variable "NAME" {
  type        = string
  description = "Release NAME"
}

variable "REPOSITORY" {
  type        = string
  description = "REPOSITORY URL where to locate the requested chart"
}

variable "CHART_NAME" {
  type        = string
  description = "Chart NAME to be installed. The chart NAME can be local path, a URL to a chart, or the NAME of the chart if REPOSITORY is specified"
}

variable "CHARTS_VERSION" {
  type        = string
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
  default     = ""
}

######### Storage account variables #########
variable "STORAGE_ACCOUNT_NAME" {
  type        = string
  description = "Nombre del storage account"
}

######### MYSQL Variables #########
variable "MYSQL_NAME" {
  type        = string
  description = "Nombre del servidor MySQL"
}

variable "MYSQL_ADMINISTRATOR_LOGIN" {
  type        = string
  description = "Nombre de usuario del administrador"
}

variable "MYSQL_ADMINISTRATOR_LOGIN_PASSWORD" {
  type        = string
  description = "Password del usuario administrador"
}

######### Private Endpoint Variables #########
variable "SUBNET_ID_MYSQL" {
  type        = string
  description = "ID de la subnet de mysql"
}
