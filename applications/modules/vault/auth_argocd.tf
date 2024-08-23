resource "vault_jwt_auth_backend" "argocd-oidc" {
  description = "OIDC Configuration for Presentium"
  path        = "argocd"

  oidc_discovery_url = "https://cd.presentium.ch/api/dex/"
  oidc_client_id     = var.oidc_client_id
  oidc_client_secret = var.oidc_client_secret
}