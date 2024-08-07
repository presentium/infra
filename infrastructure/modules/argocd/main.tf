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
      kubectl apply -k ${path.module}/kustomization.yaml
    EOT
  }
}
