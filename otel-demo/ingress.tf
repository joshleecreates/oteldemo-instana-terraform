resource "kubernetes_ingress_v1" "otel-demo-ingress" {
  metadata {
    name = "otel-demo-ingress"
  }

  spec {
    default_backend { 
      service { 
        name = "my-otel-demo-frontendproxy"
        port {
          number = "8080"
        }
      }
    }
  }
}

