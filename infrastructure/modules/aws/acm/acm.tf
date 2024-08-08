module "acm" {
  source = "terraform-aws-modules/acm/aws"

  domain_name = var.cloudflare_domain
  zone_id     = data.cloudflare_zone.this.id

  subject_alternative_names = [
    "*.${var.cloudflare_domain}",
  ]

  create_route53_records  = false
  validation_method       = "DNS"
  validation_record_fqdns = cloudflare_record.validation[*].hostname

  tags = {
    Name = var.cloudflare_domain
  }
}

resource "cloudflare_record" "validation" {
  count = length(module.acm.distinct_domain_names)

  zone_id = data.cloudflare_zone.this.id
  name    = element(module.acm.validation_domains, count.index)["resource_record_name"]
  type    = element(module.acm.validation_domains, count.index)["resource_record_type"]
  value   = trimsuffix(element(module.acm.validation_domains, count.index)["resource_record_value"], ".")
  ttl     = 60
  proxied = false

  allow_overwrite = true
}
