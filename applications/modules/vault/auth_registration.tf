resource "vault_auth_backend" "registration" {
  type = "approle"
  path = "registration"
}

resource "vault_approle_auth_backend_role" "registration-role" {
  backend        = vault_auth_backend.registration.path
  role_name      = "registration-role"
  token_policies = ["devices-${var.domain}"]

  token_ttl     = 300
  token_max_ttl = 600
}

resource "vault_approle_auth_backend_role_secret_id" "registration-secret-id" {
  backend   = vault_auth_backend.registration.path
  role_name = vault_approle_auth_backend_role.registration-role.role_name
}

resource "vault_approle_auth_backend_login" "login" {
  backend   = vault_auth_backend.registration.path
  role_id   = vault_approle_auth_backend_role.registration-role.role_id
  secret_id = vault_approle_auth_backend_role_secret_id.registration-secret-id.secret_id
}