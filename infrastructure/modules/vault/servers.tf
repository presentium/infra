resource "vault_pki_secret_backend_role" "role-servers" {
  backend    = vault_mount.pki_int.path
  issuer_ref = vault_pki_secret_backend_intermediate_set_signed.servers_intermediate.imported_issuers[0]

  name = "servers-${var.domain}"

  allowed_domains             = ["api.${var.domain}"]
  allow_bare_domains          = true
  allow_subdomains            = false
  allow_wildcard_certificates = false
  allow_localhost             = false
  allow_ip_sans               = false

  key_type = "ed25519"

  server_flag = true
  client_flag = false

  ou           = ["Servers"]
  organization = [var.organization]
  country      = [var.country]
  max_ttl      = "8760h"
  ttl          = "720h"
}

resource "vault_policy" "servers-policy" {
  name   = "servers-${var.domain}"
  policy = <<EOF
    path "pki_int/issue/servers-${var.domain}" {
      capabilities = [ "update" ]
    }
  EOF
}