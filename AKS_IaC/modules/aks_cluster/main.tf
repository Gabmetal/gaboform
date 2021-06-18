## Modulo que permite la creacion de un recurso Azure Kubernetes cluster ##

resource "azurerm_kubernetes_cluster" "main" {
  name                  = var.aks_name
  location              = var.location
  resource_group_name   = var.rg_name
  dns_prefix            = var.dns_prefix
  kubernetes_version    = var.kubernetes_version

  default_node_pool {
    name                = "defaultpool"
    enable_auto_scaling = true
    node_count          = var.node_count
    max_count           = var.max_count
    min_count           = var.min_count
    vm_size             = var.vmsizecluster
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = var.vnet_subnet
  }

  service_principal  {
    client_id     = var.serviceprincipal_id
    client_secret = var.serviceprincipal_key
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
        key_data = var.ssh_key
    }
  }

  network_profile {
      network_plugin        = "kubenet"
      load_balancer_sku     = "Standard"
      pod_cidr              = var.pod_cidr
      dns_service_ip        = var.dns_service_ip
      service_cidr          = var.service_cidr
      docker_bridge_cidr    = var.docker_bridge_cidr
  }

  tags = var.tags
}