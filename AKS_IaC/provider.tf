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
    resource_group_name  = "rg-tfstate"     #"#{sarg}#"
    storage_account_name = "satfstatemtl"   #"#{saname}#"
    container_name       = "terraformstate" #"#{contname}#"
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
    host                   = var.updating_existing_cluster ? "${data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.host}"                                 : module.aks_cluster.output.kube_config.0.host
    client_certificate     = var.updating_existing_cluster ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_certificate)}"     : base64decode(module.aks_cluster.output.kube_config.0.client_certificate)
    client_key             = var.updating_existing_cluster ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_key)}"             : base64decode(module.aks_cluster.output.kube_config.0.client_key)
    cluster_ca_certificate = var.updating_existing_cluster ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.cluster_ca_certificate)}" : base64decode(module.aks_cluster.output.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = var.updating_existing_cluster ? "${data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.host}"                                 : module.aks_cluster.output.kube_config.0.host
  client_certificate     = var.updating_existing_cluster ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_certificate)}"     : base64decode(module.aks_cluster.output.kube_config.0.client_certificate)
  client_key             = var.updating_existing_cluster ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.client_key)}"             : base64decode(module.aks_cluster.output.kube_config.0.client_key)
  cluster_ca_certificate = var.updating_existing_cluster ? "${base64decode(data.azurerm_kubernetes_cluster.existing_cluster[0].kube_config.0.cluster_ca_certificate)}" : base64decode(module.aks_cluster.output.kube_config.0.cluster_ca_certificate)
}