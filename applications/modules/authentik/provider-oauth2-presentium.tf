resource "authentik_provider_oauth2" "presentium" {
  name      = "oidc-presentium"
  client_id = "ca884da2-1542-46a7-be60-5c42a513451a"

  authorization_flow = data.authentik_flow.default-explicit.id

  redirect_uris = [
    "https://app.presentium.ch/auth/oidc/callback",               # Production domain
    "https://staging.presentium.ch/auth/oidc/callback",           # Staging domain
    "https://dashboard-presentium.nuxt.dev/auth/oidc/callback",   # NuxtHub domain
    "https://[\\w-]+.dashboard-1as.pages.dev/auth/oidc/callback", # PR / preview domains
  ]

  property_mappings = [
    data.authentik_scope_mapping.scope-email.id,
    data.authentik_scope_mapping.scope-profile.id,
    data.authentik_scope_mapping.scope-openid.id,
    authentik_scope_mapping.scope-roles.id,
  ]
}

resource "authentik_application" "presentium" {
  name              = "Presentium"
  slug              = "presentium"
  protocol_provider = authentik_provider_oauth2.presentium.id
  meta_icon         = "https://avatars.githubusercontent.com/u/174350723?s=4000&v=4"
}
