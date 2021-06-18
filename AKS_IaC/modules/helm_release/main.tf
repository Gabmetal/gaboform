
resource "helm_release" "principal" {
  name             = var.name
  repository       = var.repository #"https://charts.bitnami.com/bitnami"
  chart            = var.chart_name #"redis"
  version          = var.charts_version #"6.0.1"
  namespace        = var.namespace
  timeout          = "900"
  create_namespace = true

  values = [
    var.chart_values #"${file("values.yaml")}"
  ]

}