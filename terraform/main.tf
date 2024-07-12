terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "presentium-tfstate-nearly-good-boa"
    key    = "presentium/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-2"
}

module "cloudflare" {
  source = "./modules/cloudflare"
}
