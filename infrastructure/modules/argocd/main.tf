terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "null_resource" "argocd_apply_once" {
  triggers = {
    static = "deeply-lucky-mako"
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws eks update-kubeconfig --region ${data.aws_region.current.name} --name ${var.eks_cluster_name} &&
      kustomize build ${path.module} --enable-helm | kubectl apply -f -
    EOT
  }
}
