#!/bin/bash
set -eux
# Assuming your top-level Kustomization name is "platform" in flux-system
flux reconcile kustomization platform -n flux-system --with-source
# wait for it to settle
for i in $(seq 1 30); do
  S=$(flux get kustomization platform -n flux-system -o json | jq -r '.status.conditions[] | select(.type=="Ready") | .status')
   "$S" = "True" ] && break || sleep 5
done
flux get kustomizations -A
flux get helmreleases -A || true