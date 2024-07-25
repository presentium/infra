module "vpc_cni_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  #role_name = "vpc-cni-${var.environment}"
  role_name = "MORP-VPC-CNI-${upper(local.cluster_name)}"


  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }
}

#module "ebs_csi_irsa" {
#  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#
#  role_name = "MORP-EBS-CSI-${upper(local.cluster_name)}"
#
#  attach_ebs_csi_policy = true
#  ebs_csi_kms_cmk_ids   = [module.kms.key_id]
#
#  oidc_providers = {
#    main = {
#      provider_arn               = module.eks.oidc_provider_arn
#      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
#    }
#  }
#}
