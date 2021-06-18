resource "kubernetes_service_account" "sa_tiller" {
  metadata {
    name      = var.sa_name
    namespace = var.sa_namespace
  }
  # secret {
  #   name = "${kubernetes_secret.secret_tiller.metadata.0.name}"
  # }
}

# resource "kubernetes_secret" "secret_tiller" {
#   metadata {
#     name = var.secret_name
#   }
# }