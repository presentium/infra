resource "vault_jwt_auth_backend" "argocd-oidc" {
  description = "Github OIDC login"
  path        = "argocd"

  type = "jwt"

  oidc_discovery_url = "https://cd.presentium.ch/api/dex"
  oidc_client_id     = var.oidc_client_id
  oidc_client_secret = var.oidc_client_secret

  default_role = "argocd"

  tune {
    allowed_response_headers     = []
    audit_non_hmac_request_keys  = []
    audit_non_hmac_response_keys = []
    default_lease_ttl            = "768h"
    listing_visibility           = "unauth"
    max_lease_ttl                = "768h"
    passthrough_request_headers  = []
    token_type                   = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "argocd-oidc" {
  backend   = vault_jwt_auth_backend.argocd-oidc.path
  role_name = "argocd"
  role_type = "oidc"

  oidc_scopes = ["openid", "profile", "email", "groups"]

  allowed_redirect_uris = [
    "https://vault.presentium.ch/jwt/callback",
    "https://vault.presentium.ch/ui/vault/auth/argocd/oidc/callback",
  ]

  bound_audiences = ["vault"]
  bound_claims = {
    "groups" = "presentium:developers"
  }

  user_claim = "preferred_username"

  token_policies = ["admin"]
  token_ttl      = 3600 # 1 hour
  token_max_ttl  = 7200 # 2 hours
}