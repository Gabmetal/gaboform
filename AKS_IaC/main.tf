#
## Este File (main.tf) llama a los distintos recursos de azure que se declaran en los Bloques dentro de Modules para generar la Infraestructura en azure.

## Resource Group para los recursos.
module "resource_group_1" {
  source   = "./modules/resource_group/"
  rg_name  = var.rg_name
  location = var.location
  tags     = merge(var.tags, {managedBy="Terraform"})
}

## SSH Key
module "ssh_key" {
  source         = "./modules/ssh_key"
  public_ssh_key = var.ssh_key == "" ? "" : var.ssh_key
}

## Azure Container Registry
module "container_registry" {
  source         = "./modules/acr/"
  resource_count = var.create_new_acr ? 1 : 0
  rg_name        = module.resource_group_1.output.name
  location       = module.resource_group_1.output.location
  acrname        = var.acrname
  tags           = merge(var.tags, {managedBy="Terraform"})
  depends_on = [
    module.resource_group_1
  ]
}

## Vnet para el cluster
module "vnet" {
  source        = "./modules/vnet"
  subnet_id_aks = var.subnet_id_aks
  vnet_name     = var.vnet_name
  rg_name       = module.resource_group_1.output.name
  location      = module.resource_group_1.output.location
  address_space = var.address_space
  tags          = merge(var.tags, {managedBy="Terraform"})
  depends_on = [
    module.resource_group_1
  ]
}

## Subnet para el cluster
module "subnet" {
  source           = "./modules/subnet"
  subnet_id_aks    = var.subnet_id_aks
  subnet_name      = var.subnet_name
  rg_name          = module.resource_group_1.output.name
  vnet_name        = module.vnet.output.0.name
  address_prefixes = var.address_prefixes
  depends_on = [
    module.vnet
  ]
}

## Cluster Service Principal
module "aks_sp" {
  source            = "./modules/service_principal"
  resource_count    = var.existing_sp_id == "" && var.existing_sp_password == "" ? 1 : 0
  aks_name          = var.aks_name
  end_date_relative = var.end_date_relative
}

## Cluster AKS
module "aks_cluster" {
  source               = "./modules/aks_cluster/"
  serviceprincipal_id  = var.existing_sp_id       == "" ? module.aks_sp.sp_application[0].application_id : var.existing_sp_id
  serviceprincipal_key = var.existing_sp_password == "" ? module.aks_sp.sp_password[0].value             : var.existing_sp_password
  ssh_key              = module.ssh_key.public_ssh_key
  aks_name             = var.aks_name
  rg_name              = module.resource_group_1.output.name
  location             = module.resource_group_1.output.location
  dns_prefix           = var.dns_prefix
  vmsizecluster        = var.vmsizecluster
  kubernetes_version   = var.kubernetes_version
  vnet_subnet          = var.subnet_id_aks == "" ? module.subnet.output.0.id : var.subnet_id_aks
  max_count            = var.max_count
  min_count            = var.min_count
  node_count           = var.node_count
  pod_cidr             = var.pod_cidr
  dns_service_ip       = var.dns_service_ip
  service_cidr         = var.service_cidr
  docker_bridge_cidr   = var.docker_bridge_cidr
  tags                 = merge(var.tags, {managedBy="Terraform"})
  depends_on = [
    module.resource_group_1,
    module.vnet,
    module.subnet
  ]
}

## Attach ACR to AKS
module "attach_acr" {
  source         = "./modules/role_assignment"
  resource_count = var.enable_attach_acr == true ? 1 : 0
  role_name      = "AcrPull"
  resource_id    = module.container_registry.output[0].id
  principal_id   = module.aks_sp.sp_application[0].object_id
  depends_on = [
    module.container_registry,
    module.aks_sp
  ]
}

## Assign contributor role to resource group
module "contributor_sp" {
  source         = "./modules/role_assignment"
  resource_count = var.existing_sp_id == "" && var.existing_sp_password == "" ? 1 : 0
  role_name      = "Contributor"
  resource_id    = module.resource_group_1.output.id
  principal_id   = module.aks_sp.sp_application[0].object_id
  depends_on = [
    module.aks_sp
  ]
}

## Kubernetes service account
module "tiller_service_account" {
  source       = "./modules/service_account/"
  sa_name      = var.sa_name
  sa_namespace = var.subject_namespace
}

## Kubernetes Role Binding
module "tiller_cluster_role_binding" {
  source            = "./modules/cluster_role_bindings"
  crb_name          = var.sa_name
  api_group         = var.api_group
  binding_kind      = var.binding_kind
  role_name         = var.role_name
  subject_kind      = var.subject_kind
  subject_name      = var.sa_name
  subject_namespace = var.subject_namespace
}

## Deploy nginx Ingress chart
module "helm_release_nginx" {
  source         = "./modules/helm_release/"
  depends_on     = [module.tiller_cluster_role_binding]
  name           = var.name
  repository     = var.repository
  namespace      = var.namespace
  chart_name     = var.chart_name
  charts_version = var.charts_version
  chart_values   = file("helm_values/nginx_values.yaml")
}