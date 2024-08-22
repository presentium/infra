# Create a mount point for the Root Certiifacte authority.
resource "vault_mount" "root" {
  type                      = "pki"
  path                      = "pki-root-ca"
  default_lease_ttl_seconds = 31536000 # 1 year
  max_lease_ttl_seconds     = 157680000 # 5 years
  description               = "Root Certificate Authority"
}

# Modify the mount point and set URLs for the issuer and crl.
resource "vault_pki_secret_backend_config_urls" "config_urls" {
  depends_on              = [vault_mount.root]
  backend                 = vault_mount.root.path
  issuing_certificates    = ["https://vault.${var.domain}/v1/${vault_mount.root.path}/ca"]
  crl_distribution_points = ["https://vault.${var.domain}/v1/${vault_mount.root.path}/crl"]
}