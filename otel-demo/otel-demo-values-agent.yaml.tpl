default:
  env:
    - name: OTEL_SERVICE_NAME
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: "metadata.labels['app.kubernetes.io/component']"
    - name: OTEL_COLLECTOR_NAME
      value: '{{ include "otel-demo.name" . }}-otelcol'
    - name: OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE
      value: cumulative
    - name: OTEL_RESOURCE_ATTRIBUTES
      value: service.name=$(OTEL_SERVICE_NAME),service.namespace=opentelemetry-demo
    - name: INSTANA_SERVICE_NAME
      value: $(OTEL_SERVICE_NAME)
    - name: INSTANA_AGENT_HOST
      valueFrom:
        fieldRef:
          fieldPath: status.hostIP
    - name: INSTANA_AGENT_PORT
      value: "42699"
    - name: OTEL_K8S_POD_UID
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.uid
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
      otlp/instana:
        endpoint: "instana-agent.instana-agent.svc.cluster.local:4317"
        tls:
          insecure: true
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
