# Create a mount point for the Intermediate CA.
resource "vault_mount" "pki_int" {
  type                      = "pki"
  path                      = "pki-int-ca"
  default_lease_ttl_seconds = 63072000 # 2 years
  max_lease_ttl_seconds     = 63072000 # 2 years
  description               = "Intermediate Authority for ${var.organization}"
}