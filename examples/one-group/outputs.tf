output "admin_password" {
  description = "OpenSearch cluster admin password"
  value       = module.opensearch.admin_password
  sensitive   = true
}

output "cluster_id" {
  description = "ID of the OpenSearch cluster"
  value       = module.opensearch.cluster_id
}

output "cluster_health" {
  description = "Health status of the OpenSearch cluster"
  value       = module.opensearch.cluster_health
}

output "cluster_status" {
  description = "Status of the OpenSearch cluster"
  value       = module.opensearch.cluster_status
}

output "cluster_created_at" {
  description = "Creation timestamp of the OpenSearch cluster"
  value       = module.opensearch.cluster_created_at
}

output "hosts" {
  description = "List of OpenSearch cluster hosts"
  value       = module.opensearch.hosts
}

output "dashboard_fqdns" {
  description = "FQDNs of OpenSearch Dashboard nodes"
  value       = module.opensearch.dashboard_fqdns
}
