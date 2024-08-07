output "cluster_name" {
  description = "RDS cluster name"
  value       = module.database.cluster_database_name
}
