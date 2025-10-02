#!/bin/bash
set -eux
# Apply Job with env var SMOKE_HOST surfaced from workflow 'env'
kubectl -n "$SMOKE_NS" apply -f smoke/http-gateway.yaml
            
# Wait for job completion (120s); print logs on failure
kubectl -n "$SMOKE_NS" wait --for=condition=complete job/smoke-gateway --timeout=120s || \
   (kubectl -n "$SMOKE_NS" logs job/smoke-gateway; exit 1)