terraform {
  required_providers {
    kustomization = {
      source = "kbst/kustomization"
    }
  }
}

resource "kustomization_resource" "argocd" {
  manifest = ""
}
