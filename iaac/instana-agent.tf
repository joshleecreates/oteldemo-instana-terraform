resource "kubernetes_namespace" "instana-agent" {
  metadata {
    name = "instana-agent"
  }
}

resource "helm_release" "instana_agent" {
  name = "instana-agent"
  namespace = kubernetes_namespace.instana-agent.metadata[0].name
  repository = "https://agents.instana.io/helm"
  chart = "instana-agent"

  values = [
    "${file("agent-configuration.yaml")}"
  ]

  set {
    name = "agent.key"
    value = var.instana_key
  }

  set {
    name = "agent.endpointHost"
    value = var.instana_host
  }

  set {
    name = "zone.name"
    value = "otel-demo-kind"
  }

  set {
    name = "service.create"
    value = true
  }

  set {
    name = "cluster.name"
    value = "kind-test-cluster"
  }
}
