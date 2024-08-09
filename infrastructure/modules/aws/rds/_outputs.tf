output "cluster_name" {
  description = "RDS cluster name"
  value       = module.database.cluster_database_name
}

output "cluster_rid" {
  description = "RDS cluster resource ID"
  value       = module.database.cluster_resource_id
}
