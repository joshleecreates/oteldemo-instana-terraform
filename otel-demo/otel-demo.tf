resource "helm_release" "otel-demo" {
  name       = "my-otel-demo"
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-demo"
  
  values = [
    "${file("otel-demo-values.yaml")}"
  ]
}

