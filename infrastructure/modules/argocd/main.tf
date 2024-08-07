terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "null_resource" "argocd_apply_once" {
  triggers = {
    static = "poorly-social-pigeon"
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws eks update-kubeconfig --region ${data.aws_region.current.name} --name ${var.cluster_name} &&
      kubectl apply -k ${data.template_file.kustomization_file.filename}
    EOT
  }
}

data "template_file" "kustomization_file" {
  template = <<-EOT
    ---
    apiVersion: kustomize.config.k8s.io/v1beta1
    kind: Kustomization

    resources:
      - https://github.com/presentium/kubernetes//system/karpenter/
      - https://github.com/argoproj/argo-cd//manifests/cluster-install?ref=v2.11.7
      - https://github.com/presentium/kubernetes//argocd/boostrap.yaml
  EOT
}
