output "public_subnet" {
  value = module.vpc.public_subnets
}

output "private_subnet_primary_cidr" {
  value = data.aws_subnets.private_subnets_primary_cidr
}

output "private_subnet_secondary_cidr" {
  value = data.aws_subnets.private_subnets_secondary_cidr
}

output "intra_subnet" {
  value = module.vpc.intra_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}