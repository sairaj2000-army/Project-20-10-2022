#!/bin/sh

cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  mesh: |-
    defaultConfig:
      tracing:
        stackdriver: {}
kind: ConfigMap
metadata:
  name: istio-asm-managed
  namespace: istio-system
EOF


kubectl label namespace default istio.io/rev=asm-managed --overwrite

kubectl annotate --overwrite namespace default \
  mesh.cloud.google.com/proxy='{"managed":"true"}'
