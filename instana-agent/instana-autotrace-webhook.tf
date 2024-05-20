# resource "kubernetes_namespace" "instana-autotrace-webhook" {
#   metadata {
#     name = "instana-autotrace-webhook"
#   }
# }
#
# resource "helm_release" "instana_autotrace_webhook" {
#   name = "instana-autotrace-webhook"
#   namespace = kubernetes_namespace.instana-autotrace-webhook.metadata[0].name
#   repository = "https://agents.instana.io/helm"
#   chart = "instana-autotrace-webhook"
#
#
#   set {
#     name = "webhook.imagePullCredentials.password"
#     value = var.instana_key
#   }
# }
