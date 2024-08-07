output "public_subnet" {
  value = module.vpc.public_subnets
}

output "private_subnet_primary_cidr" {
  value = data.aws_subnets.private_subnets_primary_cidr
}

output "private_subnet_secondary_cidr" {
  value = data.aws_subnets.private_subnets_secondary_cidr
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "intra_subnet" {
  value = module.vpc.intra_subnets
}

output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
