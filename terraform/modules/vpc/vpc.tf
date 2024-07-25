module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "presentium"

  azs = data.aws_availability_zones.available_azs.names

  cidr                  = "10.0.0.0/16"
  secondary_cidr_blocks = ["100.64.0.0/16"] // EKS SUBNET

  public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = local.private_cidr
  intra_subnets      = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
  }
}