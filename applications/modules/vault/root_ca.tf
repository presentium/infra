# Create a private key for use with the Root CA.
resource "tls_private_key" "ca_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

# 
# Create a Self Signed Root Certificate Authority
#
resource "tls_self_signed_cert" "ca_cert" {
  private_key_pem = tls_private_key.ca_key.private_key_pem
  subject {
    common_name  = "${var.organization} Root CA"
    organization = var.organization
    country      = var.country
  }
  # 175200 = 20 years
  validity_period_hours = 175200
  allowed_uses = [
    "cert_signing",
    "crl_signing"
  ]
  is_ca_certificate = true
}

# Take the Root CA certificate that we have created and store it in 
# the mount point pki-root-ca.  The ca_pem_bundle in this case is
# the Certificate we generated and the key for it.
resource "vault_pki_secret_backend_config_ca" "ca_config" {
  depends_on = [vault_mount.root, tls_private_key.ca_key]
  backend    = vault_mount.root.path
  pem_bundle = "${tls_private_key.ca_key.private_key_pem}${tls_self_signed_cert.ca_cert.cert_pem}"
}

