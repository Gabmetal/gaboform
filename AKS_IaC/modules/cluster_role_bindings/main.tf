resource "kubernetes_cluster_role_binding" "crb_tiller" {
    metadata {
      name      = var.crb_name
    }
    role_ref {
      api_group = var.api_group
      kind      = var.binding_kind
      name      = var.role_name
    }
    subject {
      kind      = var.subject_kind
      name      = var.subject_name
      namespace = var.subject_namespace
    }
}