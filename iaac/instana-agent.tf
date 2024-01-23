resource "helm_release" "instana_agent" {
  name = "instana-agent"
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
}
