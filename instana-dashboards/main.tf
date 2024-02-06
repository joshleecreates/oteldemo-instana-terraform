terraform {
  required_providers {
    instana = {
      source = "gessnerfl/instana"
      version = "2.4.1"
    }
  }
}

provider "instana" {
  api_token = var.instana_api_token
  endpoint = var.instana_api_endpoint
  tls_skip_verify = false
}
