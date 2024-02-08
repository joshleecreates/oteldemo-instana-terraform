# Quickstart with Instana and the OpenTelemetry Demo using Terraform and Helm

## Prerequisites

This repository assumes that you have access to a Kubernetes cluster via `kubectl`/`helm`. You will also need Terraform or OpenTofu.

## Install the Agent and Demo

In the `otel-demo` directory:

1. `terraform init` to install Terraform dependencies
2. Create a file, `terraform.tfvars` with your Instana agent key and SaaS endpoint
3. `terraform apply` will use the Helm provider to deploy the Instana Agent and the OpenTelemetry Demo project to your cluster. A namespace for the agent will also be created

## Create a custom dashboard using the Instana Terraform Provider

In the `instana-dashboards` directory:

1. `terraform init` to install Terraform dependencies.
2. Create a file, `terraform.tfvars` with your Instana Agent API Token and SaaS tenant name.
3. `terraform apply` will use the Instana provider to create a custom dashboard.
