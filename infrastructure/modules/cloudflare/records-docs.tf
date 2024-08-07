resource "cloudflare_record" "docs_record" {
  zone_id = data.cloudflare_zone.main.id
  type    = "CNAME"
  name    = "docs"
  value   = "presentium.github.io"
  proxied = false
}
