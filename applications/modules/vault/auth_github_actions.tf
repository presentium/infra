resource "vault_jwt_auth_backend" "jwt-github-actions" {
  description = "Presentium Github Actions jwt Configuration"

  type = "jwt"
  path = "jwt-github-actions"

  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
}

resource "vault_policy" "jwt-github-actions-read-only" {
  name   = "jwt-github-actions-read-only"
  policy = file("${path.module}/policies/read-only-policy.hcl")
}

resource "vault_jwt_auth_backend_role" "jwt-github-actions-admin" {
  backend        = vault_jwt_auth_backend.jwt-github-actions.path
  role_name      = "github-actions-admin"
  token_policies = ["admin"]

  bound_claims = {
    head_ref   = "main,production"
    repository = "presentium/infrastructure"
  }
  bound_audiences   = ["https://github.com/presentium"]
  bound_claims_type = "string"
  user_claim        = "actor"
  role_type         = "jwt"
  token_ttl         = 3600 # 1 hour
}

resource "vault_jwt_auth_backend_role" "jwt-github-actions-read-only" {
  backend        = vault_jwt_auth_backend.jwt-github-actions.path
  role_name      = "github-actions-read-only"
  token_policies = ["jwt-github-actions-read-only"]

  bound_claims = {
    repository = "presentium/infrastructure"
  }
  bound_audiences   = ["https://github.com/presentium"]
  bound_claims_type = "string"
  user_claim        = "actor"
  role_type         = "jwt"
  token_ttl         = 3600 # 1 hour
}
