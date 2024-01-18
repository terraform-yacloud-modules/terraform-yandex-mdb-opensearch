output "admin_password" {
  description = "OpenSearch cluster admin password"
  value       = var.generate_admin_password ? random_password.admin_password[0].result : var.admin_password
}
