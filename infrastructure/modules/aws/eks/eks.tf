module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.20"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  cluster_endpoint_public_access = true

  cluster_addons = {
    kube-proxy = {
      addon_version = local.addon_version["kube-proxy"]
    }
    vpc-cni = {
      addon_version            = local.addon_version["vpc-cni"]
      service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
      configuration_values = jsonencode({
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
    coredns = {
      addon_version = local.addon_version["coredns"]
      configuration_values = jsonencode({
        computeType = "Fargate"
      })
    }
    aws-ebs-csi-driver = {
      addon_version            = local.addon_version["aws-ebs-csi-driver"]
      service_account_role_arn = module.ebs_csi_irsa.iam_role_arn
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet
  control_plane_subnet_ids = var.intra_subnet

  cluster_enabled_log_types = []

  # External encryption key
  create_kms_key = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }

  # Fargate profiles use the cluster primary security group so these are not utilized
  create_cluster_security_group = false
  create_node_security_group    = false

  fargate_profiles = {
    "kube-system" = {
      selectors  = [{ namespace = "kube-system", labels = { "k8s-app" = "kube-dns" } }]
      subnet_ids = var.private_subnet
    },
    "karpenter" = {
      selectors  = [{ namespace = "karpenter" }]
      subnet_ids = var.private_subnet
    },
  }

  enable_cluster_creator_admin_permissions = true
  access_entries = {
    admins = {
      kubernetes_groups = []
      principal_arn     = var.iam_admin_role_arn

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    },
  }

  tags = { "karpenter.sh/discovery" = local.cluster_name }
}

################################################################################
# Karpenter
################################################################################

module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.8.1"

  cluster_name             = module.eks.cluster_name
  irsa_oidc_provider_arn   = module.eks.oidc_provider_arn
  queue_name               = "karpenter-${local.cluster_name}"
  iam_role_use_name_prefix = false

  create_node_iam_role          = true
  iam_role_name                 = "PRES-KARPENTER-IRSA-${upper(local.cluster_name)}"
  iam_role_description          = "Karpenter IAM role for service account"
  iam_policy_name               = "PRES-KARPENTER-IRSA-${upper(local.cluster_name)}"
  iam_policy_description        = "Karpenter IAM role for service account"
  node_iam_role_name            = "PRES-KARPENTER-${upper(local.cluster_name)}"
  node_iam_role_use_name_prefix = false
  enable_irsa                   = true
  create_iam_role               = true
  create_instance_profile       = true
}
