# Se declara el Provider a utilizar de Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.46.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.3"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.5.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "#{sarg}#" #"rg-tfstate"
    storage_account_name = "#{saname}#" #"satfstatemtl"
    container_name       = "#{contname}#" #"terraformstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
  # Configuration options
}

provider "helm" {
  kubernetes {
    host                   = var.UPDATING_EXISTING_CLUSTER ? "${data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.host}"                                 : module.aks_cluster.output.kube_config.0.host
    client_certificate     = var.UPDATING_EXISTING_CLUSTER ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_certificate)}"     : base64decode(module.aks_cluster.output.kube_config.0.client_certificate)
    client_key             = var.UPDATING_EXISTING_CLUSTER ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_key)}"             : base64decode(module.aks_cluster.output.kube_config.0.client_key)
    cluster_ca_certificate = var.UPDATING_EXISTING_CLUSTER ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.cluster_ca_certificate)}" : base64decode(module.aks_cluster.output.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = var.UPDATING_EXISTING_CLUSTER ? "${data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.host}"                                 : module.aks_cluster.output.kube_config.0.host
  client_certificate     = var.UPDATING_EXISTING_CLUSTER ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_certificate)}"     : base64decode(module.aks_cluster.output.kube_config.0.client_certificate)
  client_key             = var.UPDATING_EXISTING_CLUSTER ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_key)}"             : base64decode(module.aks_cluster.output.kube_config.0.client_key)
  cluster_ca_certificate = var.UPDATING_EXISTING_CLUSTER ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.cluster_ca_certificate)}" : base64decode(module.aks_cluster.output.kube_config.0.cluster_ca_certificate)
}