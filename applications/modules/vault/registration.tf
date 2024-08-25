resource "vault_pki_secret_backend_role" "role-registration" {
  backend    = vault_mount.pki_int.path
  issuer_ref = vault_pki_secret_backend_intermediate_set_signed.registration_intermediate.imported_issuers[0]

  name = "registration-${var.domain}"

  allowed_domains             = ["registration.${var.domain}"]
  allow_bare_domains          = true
  allow_subdomains            = false
  allow_wildcard_certificates = false
  allow_localhost             = false
  allow_ip_sans               = false

  key_type = "ec"
  key_bits = 256

  server_flag = false
  client_flag = false

  ou           = ["Registration"]
  organization = [var.organization]
  country      = [var.country]
  max_ttl      = "31536000" #8760h
  ttl          = "2592000"  #720h
}

resource "vault_policy" "registration-policy" {
  name   = "registration-${var.domain}"
  policy = <<EOF
    path "pki_int/issue/registration-${var.domain}" {
      capabilities = [ "update" ]
    }
  EOF
}