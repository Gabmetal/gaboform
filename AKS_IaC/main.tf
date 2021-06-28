#
## Este File (main.tf) llama a los distintos recursos de azure que se declaran en los Bloques dentro de Modules para generar la Infraestructura en azure.

## Resource Group para los recursos.
module "resource_group_1" {
  source   = "./modules/resource_group/"
  rg_name  = var.RG_NAME
  location = var.LOCATION
  tags     = merge(var.TAGS, {managedBy="Terraform"})
}

## SSH Key
module "ssh_key" {
  source         = "./modules/ssh_key"
  public_ssh_key = var.SSH_KEY == "" ? "" : var.SSH_KEY
}

## Azure Container Registry
module "container_registry" {
  source         = "./modules/acr/"
  resource_count = var.CREATE_NEW_ACR ? 1 : 0
  rg_name        = module.resource_group_1.output.name
  location       = module.resource_group_1.output.location
  acrname        = var.ACRNAME
  tags           = merge(var.TAGS, {managedBy="Terraform"})
  depends_on = [
    module.resource_group_1
  ]
}

## Vnet para el cluster
module "vnet" {
  source        = "./modules/vnet"
  subnet_id_aks = var.SUBNET_ID_AKS
  vnet_name     = var.VNET_NAME
  rg_name       = module.resource_group_1.output.name
  location      = module.resource_group_1.output.location
  address_space = var.ADDRESS_SPACE
  tags          = merge(var.TAGS, {managedBy="Terraform"})
  depends_on = [
    module.resource_group_1
  ]
}

## Subnet para el cluster
module "subnet" {
  source           = "./modules/subnet"
  subnet_id_aks    = var.SUBNET_ID_AKS
  subnet_name      = var.SUBNET_NAME
  rg_name          = module.resource_group_1.output.name
  vnet_name        = var.SUBNET_ID_AKS == "" ? module.vnet.output[0].name : ""
  address_prefixes = var.ADDRESS_PREFIXES
  depends_on = [
    module.vnet
  ]
}

## Cluster Service Principal
module "aks_sp" {
  source            = "./modules/service_principal"
  resource_count    = var.EXISTING_SP_ID == "" ? 1 : 0
  aks_name          = var.AKS_NAME
  end_date_relative = var.END_DATE_RELATIVE
}

## Cluster AKS
module "aks_cluster" {
  source               = "./modules/aks_cluster/"
  serviceprincipal_id  = var.EXISTING_SP_ID   == "" ? module.aks_sp.sp_application[0].application_id : var.EXISTING_SP_ID
  serviceprincipal_key = var.EXISTING_SP_ID   == "" ? module.aks_sp.sp_password[0].value             : var.EXISTING_SP_PASSWORD
  ssh_key              = module.ssh_key.public_ssh_key
  aks_name             = var.AKS_NAME
  rg_name              = module.resource_group_1.output.name
  location             = module.resource_group_1.output.location
  dns_prefix           = var.DNS_PREFIX
  vmsizecluster        = var.VMSIZECLUSTER
  kubernetes_version   = var.KUBERNETES_VERSION
  vnet_subnet          = var.SUBNET_ID_AKS == "" ? module.subnet.output[0].id : var.SUBNET_ID_AKS
  max_count            = var.MAX_COUNT
  min_count            = var.MIN_COUNT
  node_count           = var.NODE_COUNT
  pod_cidr             = var.POD_CIDR
  dns_service_ip       = var.DNS_SERVICE_IP
  service_cidr         = var.SERVICE_CIDR
  docker_bridge_cidr   = var.DOCKER_BRIDGE_CIDR
  tags                 = merge(var.TAGS, {managedBy="Terraform"})
  depends_on = [
    module.resource_group_1,
    module.vnet,
    module.subnet
  ]
}

## Attach ACR to AKS
module "attach_acr" {
  source         = "./modules/role_assignment"
  resource_count = var.ENABLE_ATTACH_ACR == true ? 1 : 0
  role_name      = "AcrPull"
  resource_id    = var.CREATE_NEW_ACR ? module.container_registry.output[0].id : data.azurerm_container_registry.existing_acr[0].id
  principal_id   = var.EXISTING_SP_ID == "" ? module.aks_sp.sp_application[0].object_id : data.azuread_service_principal.existing_sp[0].object_id
  depends_on = [
    module.container_registry,
    module.aks_sp
  ]
}

## Assign contributor role to resource group
module "contributor_sp" {
  source         = "./modules/role_assignment"
  resource_count = var.EXISTING_SP_ID == "" && var.EXISTING_SP_PASSWORD == "" ? 1 : 0
  role_name      = "Contributor"
  resource_id    = module.resource_group_1.output.id
  principal_id   = var.EXISTING_SP_ID == "" ? module.aks_sp.sp_application[0].object_id : data.azuread_service_principal.existing_sp[0].object_id
  depends_on = [
    module.aks_sp
  ]
}

## Kubernetes service account
module "tiller_service_account" {
  source       = "./modules/service_account/"
  sa_name      = var.SA_NAME
  sa_namespace = var.SUBJECT_NAMESPACE
}

## Kubernetes Role Binding
module "tiller_cluster_role_binding" {
  source            = "./modules/cluster_role_bindings"
  crb_name          = var.SA_NAME
  api_group         = var.API_GROUP
  binding_kind      = var.BINDING_KIND
  role_name         = var.ROLE_NAME
  subject_kind      = var.SUBJECT_KIND
  subject_name      = var.SA_NAME
  subject_namespace = var.SUBJECT_NAMESPACE
}

## Deploy nginx Ingress chart
module "helm_release_nginx" {
  source         = "./modules/helm_release/"
  depends_on     = [module.tiller_cluster_role_binding]
  name           = var.NAME
  repository     = var.REPOSITORY
  namespace      = var.NAMESPACE
  chart_name     = var.CHART_NAME
  charts_version = var.CHARTS_VERSION
  chart_values   = file("helm_values/nginx_values.yaml")
}

## Storage Accounts for logs purposes
module "storage-account1" {
  source               = "./modules/storage_account/"
  storage_account_name = var.STORAGE_ACCOUNT_NAME
  rg_name              = module.resource_group_1.output.name
  location             = module.resource_group_1.output.location
}

## MySQl DB
module "mysql_server" {
  source                       = "./modules/mysqldb/"
  resource_count               = var.MYSQL_NAME == "" ? 0 : 1
  name                         = var.MYSQL_NAME
  location                     = module.resource_group_1.output.location
  rg_name                      = module.resource_group_1.output.name
  administrator_login          = var.MYSQL_ADMINISTRATOR_LOGIN
  administrator_login_password = var.MYSQL_ADMINISTRATOR_LOGIN_PASSWORD
}

## MySQL private Enpoint
module "primer_private_endpoint" {
  source                     = "./modules/private_endpoint/"
  resource_count             = var.SUBNET_ID_MYSQL == "" ? 0 : 1
  location                   = module.resource_group_1.output.location
  rg_name                        = module.resource_group_1.output.name
  # ATENCION: Aqui se puede pasar el valor de la Subnet mediante un DATA SOURCE, generado en un file extra "Data.tf" con el valor obtenido, o, se puede pasar el ID del recurso directamente
  subnet_id                  = var.SUBNET_ID_MYSQL
  resource_id_to_connect     = module.mysql_server.output[0].id #Recurso al cual de asocia el private endpoint
  tags                       = merge(var.TAGS, {managedBy="Terraform"})
}
