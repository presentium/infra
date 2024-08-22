locals {
  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  addon_version = {
    "coredns"            = "v1.11.1-eksbuild.9"
    "kube-proxy"         = "v1.30.0-eksbuild.3"
    "vpc-cni"            = "v1.18.1-eksbuild.3"
    "aws-ebs-csi-driver" = "v1.33.0-eksbuild.1"
  }

  database_users = {
    "authentik"   = { username = "authentik", service_account = "authentik:authentik" },
    "api-staging" = { username = "${var.cluster_name}_staging", service_account = "staging-${var.cluster_name}:${var.cluster_name}-api" },
    "api-prod"    = { username = "${var.cluster_name}_prod", service_account = "prod-${var.cluster_name}:${var.cluster_name}-api" }
  }
}
