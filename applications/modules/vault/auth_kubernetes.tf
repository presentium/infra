resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "presentium" {
  backend = vault_auth_backend.kubernetes.path

  kubernetes_host = "https://kubernetes.default.svc"
}

resource "vault_kubernetes_auth_backend_role" "presentium_api" {
  backend = vault_auth_backend.kubernetes.path

  role_name = "kubernetes"

  bound_service_account_names      = ["presentium-api"]
  bound_service_account_namespaces = ["staging-presentium", "prod-presentium"]

  token_ttl      = 3600
  token_policies = [vault_policy.servers-policy.name]
}
