locals {

  cluster_name = "presentium"

  cluster_version = "1.30"
  addon_version = {
    #    "aws-ebs-csi-driver" = "v1.32.0-eksbuild.1"
    "coredns"    = "v1.11.1-eksbuild.9"
    "kube-proxy" = "v1.30.0-eksbuild.3"
    "vpc-cni"    = "v1.18.1-eksbuild.3"
  }

}