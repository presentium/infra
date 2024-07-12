resource "cloudflare_record" "main_landing_record" {
  zone_id = data.cloudflare_zone.main.id
  type    = "CNAME"
  name    = "@"
  value   = "presentium.github.io"
  proxied = false
}
