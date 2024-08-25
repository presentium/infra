data "aws_region" "current" {}

data "cloudflare_zone" "this" {
  name = var.cloudflare_domain
}
