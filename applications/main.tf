terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = ">= 2024.6.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.3"
    }
  }

  backend "s3" {
    bucket = "presentium-tfstate-nearly-good-boa"
    key    = "presentium/terraform-applications.tfstate"
  }

  required_version = ">= 1.9.0"
}

// Provider configuration

provider "authentik" {
  url   = var.authentik_url
  token = var.authentik_api_key
}

# provider "vault" {
#   address = ""
#}

##########################################
## Application modules
##########################################

module "authentik" {
  source = "./modules/authentik"
  providers = {
    authentik = authentik
  }
}

# module "vault" {
#   source = "./modules/vault"
#   providers = {
#     vault = vault
#   }
# }
