# Data source to get available AZs
data "aws_availability_zones" "available_azs" {
  state = "available"
}

# List of all the subnet ids
data "aws_subnets" "private_subnets_secondary_cidr" {
  depends_on = [module.vpc]
  filter {
    name   = "cidr-block"
    values = local.private_cidr_secondary
  }
}

data "aws_subnets" "private_subnets_primary_cidr" {
  depends_on = [module.vpc]
  filter {
    name   = "cidr-block"
    values = local.private_cidr_primary
  }
}