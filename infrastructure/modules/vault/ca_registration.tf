#
# Step 1
#
# Create a CSR (Certificate Signing Request)
# Behind the scenes this creates a new private key, that has signed the 
# CSR.  Later on, when we store the signed Intermediate Cert, that 
# certificate must match the Private Key generated here.
# I don't see an obvious way to use these APIs to put an intermediate cert 
# into vault that was generated outside of vault.
resource "vault_pki_secret_backend_intermediate_cert_request" "registration_intermediate" {
  depends_on = [vault_mount.pki_int]

  backend            = vault_mount.pki_int.path
  type               = "internal"
  common_name        = "${var.organization} Registration Intermediate Certificate"
  format             = "pem"
  private_key_format = "der"
  key_type           = "ed25519"
  key_bits           = "0" # not used for ed25519
}

#
# Step 2
#
# Have the Root CA Sign our CSR
resource "vault_pki_secret_backend_root_sign_intermediate" "registration_intermediate" {
  depends_on = [vault_pki_secret_backend_intermediate_cert_request.registration_intermediate, vault_pki_secret_backend_config_ca.ca_config]
  backend    = vault_mount.root.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.registration_intermediate.csr
  common_name          = vault_pki_secret_backend_intermediate_cert_request.registration_intermediate.common_name
  exclude_cn_from_sans = true
  ou                   = "Registration"
  organization         = var.organization
  ttl                  = "43800h"
}

#
# Step 3
#
# Now that CSR is processed and we have a signed cert
# Put the Certificate, and The Root CA into the backend 
# mount point.  IF you do not put the CA in here, the 
# chained_ca output of a generated cert will only be 
# the intermedaite cert and not the whole chain.
resource "vault_pki_secret_backend_intermediate_set_signed" "registration_intermediate" {
  backend     = vault_mount.pki_int.path
  certificate = "${vault_pki_secret_backend_root_sign_intermediate.registration_intermediate.certificate}\n${tls_self_signed_cert.ca_cert.cert_pem}"
}