opentelemetry-collector:
  config:
    exporters:
      otlp:
        endpoint: '{{ include "otel-demo.name" . }}-jaeger-collector:4317'
        tls:
          insecure: true
      # Create an exporter to Prometheus (metrics)
      otlphttp/prometheus:
        endpoint: 'http://{{ include "otel-demo.name" . }}-prometheus-server:9090/api/v1/otlp'
        tls:
          insecure: true
      # Create an exporter to the Instana Backend
      otlp/instana:
        endpoint: "otlp-red-saas.instana.io:4317"
        headers:
          x-instana-key: ${instana_key}
    service:
      pipelines:
        logs:
          exporters:
            - debug
            - otlp/instana
          processors:
            - k8sattributes
            - memory_limiter
            - batch
          receivers:
            - otlp
        metrics:
          exporters:
            - otlphttp/prometheus
            - otlp/instana
            - debug
          processors:
            - k8sattributes
            - memory_limiter
            - transform
            - resource
            - batch
          receivers:
            - otlp
            - prometheus
        traces:
          exporters:
            - otlp
            - otlp/instana
            - debug
          processors:
            - k8sattributes
            - memory_limiter
            - resource
            - batch
          receivers:
            - otlp
            - jaeger
            - zipkin
