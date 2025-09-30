output "admin_password" {
  description = "The admin password for the OpenSearch cluster. "
  value       = var.generate_admin_password ? random_password.admin_password[0].result : var.admin_password
  sensitive   = true
}

output "cluster_id" {
  description = "ID of the OpenSearch cluster"
  value       = yandex_mdb_opensearch_cluster.main.id
}

output "cluster_health" {
  description = "The current health status of the OpenSearch cluster (e.g., HEALTHY, DEGRADED, UNHEALTHY)."
  value       = yandex_mdb_opensearch_cluster.main.health
}

output "cluster_status" {
  description = "The current operational status of the OpenSearch cluster (e.g., RUNNING, STOPPED, STARTING)."
  value       = yandex_mdb_opensearch_cluster.main.status
}

output "cluster_created_at" {
  description = "The timestamp when the OpenSearch cluster was created in Yandex Cloud."
  value       = yandex_mdb_opensearch_cluster.main.created_at
}

output "hosts" {
  description = "A list of all hosts in the OpenSearch cluster, including their FQDNs, IP addresses, and node types."
  value       = yandex_mdb_opensearch_cluster.main.hosts
}

output "dashboard_fqdns" {
  description = "A list of fully qualified domain names (FQDNs) of the OpenSearch Dashboard nodes for accessing the web interface."
  value = [
    for host in yandex_mdb_opensearch_cluster.main.hosts :
    host.fqdn if host.type == "DASHBOARDS"
  ]
}
