locals {
  private_cidr_primary   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  private_cidr_secondary = ["100.64.0.0/20", "100.64.16.0/20", "100.64.32.0/20"]
  private_cidr           = concat(local.private_cidr_primary, local.private_cidr_secondary)
}