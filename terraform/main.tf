terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.57"
    }
  }

  backend "s3" {
    bucket = "presentium-tfstate-nearly-good-boa"
    key    = "presentium/terraform.tfstate"
  }
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::123247571664:role/cicd"
  }
  region = "eu-west-1"
}

module "cloudflare" {
  source = "./modules/cloudflare"
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"

  intra_subnet   = module.vpc.intra_subnet
  private_subnet = module.vpc.private_subnet_secondary_cidr.ids
  vpc_id         = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"
}