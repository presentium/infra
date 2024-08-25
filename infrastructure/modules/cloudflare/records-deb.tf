resource "cloudflare_record" "deb_record" {
  zone_id = data.cloudflare_zone.main.id
  type    = "CNAME"
  name    = "deb"
  content = "presentium.github.io"
  proxied = false
}
