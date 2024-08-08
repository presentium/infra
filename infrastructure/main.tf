## AWS

module "vpc" {
  source = "./modules/aws/vpc"
  providers = {
    aws = aws
  }
}

module "eks" {
  source = "./modules/aws/eks"
  providers = {
    aws = aws
  }

  cluster_name = local.project_name

  rds_database_name  = module.rds.cluster_name
  iam_admin_role_arn = module.iam.eks_admin_role_arn

  vpc_id         = module.vpc.vpc_id
  intra_subnet   = module.vpc.intra_subnet
  private_subnet = module.vpc.private_subnet_secondary_cidr.ids
}

module "rds" {
  source = "./modules/aws/rds"
  providers = {
    aws = aws
  }

  database_name = local.project_name

  vpc_id                         = module.vpc.vpc_id
  vpc_private_cidr_blocks        = module.vpc.private_subnets_cidr_blocks
  vpc_database_subnet_group_name = module.vpc.database_subnet_group_name
}

module "iam" {
  source = "./modules/aws/iam"
  providers = {
    aws = aws
  }
}

module "acm" {
  source = "./modules/aws/acm"
  providers = {
    aws        = aws
    cloudflare = cloudflare
  }

  cloudflare_domain = module.cloudflare.domain
}

## Cloudflare

module "cloudflare" {
  source = "./modules/cloudflare"
  providers = {
    cloudflare = cloudflare
  }
}

## ArgoCD

module "argocd" {
  source = "./modules/argocd"
  providers = {
    aws = aws
  }

  eks_cluster_name = module.eks.cluster_name
}
