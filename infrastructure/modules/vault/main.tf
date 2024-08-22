resource "vault_policy" "admin-policy" {
  name   = "admin"
  policy = file("${path.module}/policies/admin-policy.hcl")
}