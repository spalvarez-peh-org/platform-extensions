package main

# Require HelmRelease chart.spec.version to be pinned
deny contains msg if {
  input.kind == "HelmRelease"
  not input.spec.chart.spec.version
  msg := sprintf("HelmRelease %s must pin chart.spec.version", [input.metadata.name])
}
