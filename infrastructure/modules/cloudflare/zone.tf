data "cloudflare_zone" "main" {
  name = "presentium.ch"
}

resource "cloudflare_zone_settings_override" "main-settings" {
  zone_id = data.cloudflare_zone.main.id

  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    ssl                      = "strict"
    min_tls_version          = "1.1"
    tls_1_3                  = "on"
  }
}
