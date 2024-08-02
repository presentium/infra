terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}

resource "helm_release" "argocd" {
  name = "presentium-argocd"

  namespace        = "argocd"
  create_namespace = "true"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.3.11"

  values = [
    templatefile("values-main.yaml", {
      github_client_id     = var.github_oauth_client_id
      github_client_secret = var.github_oauth_client_secret
      repo_server_role_arn = var.repo_server_role_arn
    })
  ]

  wait          = true
  wait_for_jobs = true
  timeout       = var.timeout_seconds
}

resource "helm_release" "argocd-apps" {
  depends_on = [helm_release.argocd]
  name       = "presentium-system-apps"

  namespace        = "argocd"
  create_namespace = "true"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "2.0.0"

  values = [
    templatefile("values-apps.yaml", {
    })
  ]

  timeout = var.timeout_seconds
}
