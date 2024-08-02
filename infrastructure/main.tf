terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.14"
    }
  }

  backend "s3" {
    bucket = "presentium-tfstate-nearly-good-boa"
    key    = "presentium/terraform.tfstate"
  }

  required_version = ">= 1.9.0"
}

// Provider configuration

provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = var.aws_arn
  }
}

provider "cloudflare" {
  api_key = var.cloudflare_api_key
}

provider "helm" {
  kubernetes {
    host                   = module.eks.custer_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
    token                  = module.eks.cluster_token
    load_config_file       = false
  }
}

##########################################
## Infrastructure components
##########################################

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

  intra_subnet   = module.vpc.intra_subnet
  private_subnet = module.vpc.private_subnet_secondary_cidr.ids
  vpc_id         = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/aws/iam"
  providers = {
    aws = aws
  }
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
    helm = helm
  }

  github_oauth_client_id     = var.argocd_github_oauth_client_id
  github_oauth_client_secret = var.argocd_github_oauth_client_secret
}
