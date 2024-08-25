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

##########################################
## Application modules
##########################################

module "authentik" {
  source = "./modules/authentik"
  providers = {
    authentik = authentik
  }
}

module "vault" {
  source = "./modules/vault"

  domain             = "presentium.ch"
  organization       = "Presentium"
  country            = "CH"
  oidc_client_id     = var.vault_oidc_client_id
  oidc_client_secret = var.vault_oidc_client_secret
}