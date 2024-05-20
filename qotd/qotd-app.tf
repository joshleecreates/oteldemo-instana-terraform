resource "kubernetes_namespace" "qotd" {
  metadata {
    name = "qotd"
  }
}

resource "kubernetes_namespace" "qotd-load" {
  metadata {
    name = "qotd-load"
  }
}

resource "helm_release" "qotd-demo" {
  name       = "qotd-demo"
  namespace = kubernetes_namespace.qotd.metadata[0].name
  repository = "https://gitlab.com/api/v4/projects/26143345/packages/helm/stable"
  chart      = "qotd"
  version    = "5.1.0"

  set {
    name = "useNodePort"
    value = true
  }
}
