
English version [[LINK](https://github.com/Gabmetal/gaboform/blob/azure/aks/README.md)]

  

# Pre-requisitos

Para permitir que terraform se ejecute y construya todos los recursos definidos aquí, necesitará crear un principal de servicio con el rol de "Owner" en la suscripción de destino y "Application Administrator" en su Azure Active Directory. Con estos roles, terraform podrá desplegar recursos, crear servicios principales y asignarlos al clúster AKS.
  

Antes de ejecutar Terraform tendrá que establecer estas variables de entorno en su pipeline o workstation.

| Variable Name | Description | Default | Type |
|--|--|--|--|
| ARM_CLIENT_ID | Service principal app_id que Terraform utilizará para crear recursos. | null | String |
| ARM_CLIENT_SECRET | Service principal password que Terraform utilizará para crear recursos | null | String |
| ARM_SUBSCRIPTION_ID | ID de suscripción de destino | null | String |
| ARM_TENANT_ID | tenant ID de la suscripción | null | String |
| TF_VAR_ssh_key | Si ya tiene una clave ssh puede establecerla aquí. Si no proporciona una, terraform creará una nueva y la asignará a los nodos | null | String |
| TF_VAR_updating_existing_cluster | Si estás actualizando la configuración de un cluster existente, ponlo en true | false | Bool |
| TF_VAR_location | Ubicación en la que desea desplegar los recursos en Azure | eastus2 | String |
| TF_VAR_rg_name | Nombre del grupo de recursos en el que desea desplegar los recursos del clúster | aks-test-rg | String |
| TF_VAR_tags |  Etiquetas a aplicar a cada recurso | { environment="develop", application="test" } | Map(string)
| TF_VAR_acrname | Nombre a asignar al Azure Container Registry | testacr001 | String |
| TF_VAR_enable_attach_acr | Si quieres asignar el rol ACRPull al cluster AKS, ponlo en true | true | Bool |
| TF_VAR_create_new_acr | Si desea crear un nuevo new Azure Container Registry para este cluster ponlo en true | true | Bool
| TF_VAR_end_date_relative | Tiempo relativo de expiración de las credenciales | 8760h | String
| TF_VAR_vnet_name | Nombre de la red virtual que Terraform creará si TF_VAR_subnet_id_aks es null | aks-vnet | String
| TF_VAR_address_space | Espacios de direcciones de la red virtual Terraform creará si TF_VAR_subnet_id_aks es null | ["10.0.0.0/16"] | list(string)
| TF_VAR_subnet_name | Nombre de la subred que Terraform creará si TF_VAR_subnet_id_aks es null | aks-subnet | String
| TF_VAR_address_prefixes | Prefijos de dirección de subred del clúster AKS | ["10.0.1.0/24"] | list(string)
| TF_VAR_existing_sp_id | Si ya tienes un service principal para asignar a este cluster pon el id aquí | null | string
| TF_VAR_existing_sp_password | Si ya tienes un service principal para asignar a este cluster pon el password aquí | null | string
| TF_VAR_aks_name | Nombre del recurso AKS | testaks-01 | String |
| TF_VAR_dns_prefix | Prefijo DNS al crear el cluster gestionado | testaks-01 | String
| TF_VAR_vmsizecluster | Tamaño de la máquina virtual de Azure que se utilizará en los nodos | standard_a2_v2 | String
| TF_VAR_kubernetes_version | Versión de Kubernetes a desplegar | 1.18.17 | String
| TF_VAR_subnet_id_aks | Si desea crear un clúster AKS utilizando una subred existente, configure esta variable con el ID de recursos de Azure de Sunet | null | String
| TF_VAR_node_count | El número inicial de nodos que deben existir en este grupo de nodos | 1 | number
| TF_VAR_max_count |  Número máximo de nodos que deberían existir en este grupo de nodos | 2 | number
| TF_VAR_min_count | Número mínimo de nodos que deberían existir en este grupo de nodos | 1 | number
| TF_VAR_pod_cidr | El CIDR que se utilizará para las direcciones IP del pod | 10.244.0.0/16 | String
| TF_VAR_dns_service_ip | Dirección IP dentro del rango de direcciones del servicio Kubernetes que será utilizado por el descubrimiento del servicio del cluster (kube-dns) El cual debe terminar en .10 | 10.0.0.10 | String
| TF_VAR_service_cidr | El rango de red utilizado por los servicios de Kubernetes | 10.0.0.0/16 | String
| TF_VAR_docker_bridge_cidr | Dirección IP (en notación CIDR) utilizada como dirección IP del puente Docker en los nodos | 172.17.0.1/16 | String
| TF_VAR_sa_name | Nombre de la cuenta de servicio, debe ser único para asignarlo a AKS. | null | String
| TF_VAR_api_group | El grupo de la API para tomar decisiones de autorización. | rbac.authorization.k8s.io | String
| TF_VAR_binding_kind | Tipo de enlace que se va a utilizar | ClusterRole | String
| TF_VAR_role_name | The name of this ClusterRole to bind Subjects to | cluster-admin | String
| TF_VAR_subject_kind | El tipo de vinculación a utilizar | ServiceAccount | String
| TF_VAR_subject_namespace | Namespace defines the namespace of the ServiceAccount to bind to. This value only applies to kind ServiceAccount | kube-system | String
| TF_VAR_namespace | The namespace to install the release into | null | String
| TF_VAR_name | Release name | null | String
| TF_VAR_repository | Repository URL where to locate the requested chart | null | String
| TF_VAR_chart_name | Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified | null | string
| TF_VAR_charts_version | Specify the exact chart version to install. If this is not specified, the latest version is installed. | null | String
---
# Despliegue de AKS
Para desplegar el clúster AKS con todas las dependencias puede ejecutar:
```
    cd AKS_IaC
    terraform plan -out=tfplan
    terraform apply tfplan
```
