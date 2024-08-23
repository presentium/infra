variable "authentik_url" {
  description = "Authentik management URL"
}

variable "authentik_api_key" {
  description = "Authentik management API key"
  sensitive   = true
}

variable "vault_oidc_client_id" {
  description = "Vault OIDC Client ID"
}

variable "vault_oidc_client_secret" {
  description = "Vault OIDC Client Secret"
  sensitive   = true
}