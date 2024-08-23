variable "aws_region" {
  description = "AWS region to deploy the resources"
}

variable "aws_arn" {
  description = "AWS ARN on which to assume the role"
}

variable "cloudflare_api_key" {
  description = "Cloudflare management API key"
  sensitive   = true
}

variable "dkim_public_key" {
  description = "Public key for DKIM"
}

variable "dkim_private_key" {
  description = "Private key for DKIM"
  sensitive   = true
}

variable "vault_oidc_client_id" {
  description = "Vault OIDC Client ID"
}

variable "vault_oidc_client_secret" {
  description = "Vault OIDC Client Secret"
  sensitive   = true
}