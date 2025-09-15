output "admin_password" {
  description = "OpenSearch cluster admin password"
  value       = var.generate_admin_password ? random_password.admin_password[0].result : var.admin_password
  sensitive   = true
}

output "cluster_id" {
  description = "ID of the OpenSearch cluster"
  value       = yandex_mdb_opensearch_cluster.main.id
}

output "cluster_health" {
  description = "Health status of the OpenSearch cluster"
  value       = yandex_mdb_opensearch_cluster.main.health
}

output "cluster_status" {
  description = "Status of the OpenSearch cluster"
  value       = yandex_mdb_opensearch_cluster.main.status
}

output "cluster_created_at" {
  description = "Creation timestamp of the OpenSearch cluster"
  value       = yandex_mdb_opensearch_cluster.main.created_at
}

output "hosts" {
  description = "List of OpenSearch cluster hosts"
  value       = yandex_mdb_opensearch_cluster.main.hosts
}

output "dashboard_fqdns" {
  description = "FQDNs of OpenSearch Dashboard nodes"
  value = [
    for host in yandex_mdb_opensearch_cluster.main.hosts :
    host.fqdn if host.type == "DASHBOARDS"
  ]
}
