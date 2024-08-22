resource "vault_pki_secret_backend_role" "role-devices" {
  backend    = vault_mount.pki_int.path
  issuer_ref = vault_pki_secret_backend_intermediate_set_signed.devices_intermediate.imported_issuers[0]

  name = "devices-${var.domain}"

  allowed_domains             = ["devices.${var.domain}"]
  allow_bare_domains          = false
  allow_subdomains            = true
  allow_wildcard_certificates = false
  allow_localhost             = false
  allow_ip_sans               = false

  key_type = "ed25519"

  server_flag = false
  client_flag = true

  ou           = ["Devices"]
  organization = [var.organization]
  country      = [var.country]
  max_ttl      = "8760h"
  ttl          = "720h"
}

resource "vault_policy" "devices-policy" {
  name   = "devices-${var.domain}"
  policy = file("${path.module}/policies/devices-policy.hcl")
}