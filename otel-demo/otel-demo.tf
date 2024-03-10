resource "helm_release" "otel-demo" {
  name       = "my-otel-demo"
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-demo"
  version    = "0.28.3"
  values = [
    templatefile("${path.module}/otel-demo-values-backend.yaml.tpl", {instana_key = var.instana_key})
  ]
}

