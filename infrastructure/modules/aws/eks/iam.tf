module "vpc_cni_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "PRES-VPC-CNI-${upper(module.eks.cluster_name)}"

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }
}

module "alb_controller_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "PRES-ALB-CONTROLLER-${upper(module.eks.cluster_name)}"

  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

module "sops_kms_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "PRES-SOPS-KMS-${upper(module.eks.cluster_name)}"
  role_policy_arns = {
    sops = aws_iam_policy.sops_policy.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["argocd:argocd-repo-server"]
    }
  }
}

module "dbconnect_irsa" {
  for_each = local.database_users
  source   = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "PRES-DB-${upper(each.key)}-${upper(module.eks.cluster_name)}"
  role_policy_arns = {
    rds = aws_iam_policy.rds_policy[each.key].arn
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = [each.value["service_account"]]
    }
  }
}
