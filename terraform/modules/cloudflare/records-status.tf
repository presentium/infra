resource "cloudflare_record" "status_record" {
  zone_id = data.cloudflare_zone.main.id
  type    = "CNAME"
  name    = "status"
  value   = "presentium.github.io"
  proxied = false
}
