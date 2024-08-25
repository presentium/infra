resource "vault_auth_backend" "registration-cert" {
  path = "registration-cert"
  type = "cert"
}

resource "vault_cert_auth_backend_role" "registration-cert" {
  name    = "registration-cert"
  backend = vault_auth_backend.registration-cert.path

  certificate                  = vault_pki_secret_backend_intermediate_set_signed.registration_intermediate.certificate
  allowed_organizational_units = ["Registration"]
  allowed_names                = ["registration.${var.domain}"]

  token_ttl      = 300
  token_max_ttl  = 600
  token_policies = [vault_policy.devices-policy.name]
}