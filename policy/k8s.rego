package main

# deny :latest images
deny contains msg if {
  input.kind == "Deployment"
  some i
  endswith(input.spec.template.spec.containers[i].image, ":latest")
  msg := sprintf(
    "Deployment %s uses :latest tag in container %s",
    [input.metadata.name, input.spec.template.spec.containers[i].name],
  )
}
