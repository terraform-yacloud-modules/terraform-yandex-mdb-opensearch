output "admin_password" {
  description = "OpenSearch cluster admin password"
  value       = module.opensearch.admin_password
  sensitive   = true
}
