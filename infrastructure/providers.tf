provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = var.aws_arn
  }

  default_tags {
    tags = {
      Terraform = "true"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_key
}
