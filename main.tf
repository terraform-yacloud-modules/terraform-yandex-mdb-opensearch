resource "random_password" "admin_password" {
  count            = var.generate_admin_password ? 1 : 0
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "yandex_mdb_opensearch_cluster" "main" {
  name        = var.name
  description = var.description
  labels      = var.labels

  folder_id = local.folder_id

  environment         = var.environment
  service_account_id  = var.service_account_id
  deletion_protection = var.deletion_protection

  network_id         = var.network_id
  security_group_ids = var.security_group_ids

  config {
    version        = var.opensearch_version
    admin_password = var.generate_admin_password ? random_password.admin_password[0].result : var.admin_password

    opensearch {
      plugins = var.opensearch_plugins

      dynamic "node_groups" {
        for_each = var.opensearch_nodes
        content {
          name             = node_groups.key
          hosts_count      = node_groups.value.hosts_count
          zone_ids         = node_groups.value.zones_ids
          subnet_ids       = node_groups.value.subnet_ids
          assign_public_ip = node_groups.value.assign_public_ip
          roles            = node_groups.value.roles

          resources {
            resource_preset_id = node_groups.value.resources.resource_preset_id
            disk_size          = node_groups.value.resources.disk_size
            disk_type_id       = node_groups.value.resources.disk_type_id
          }
        }
      }
    }

    dashboards {
      dynamic "node_groups" {
        for_each = var.dashboard_nodes
        content {
          name             = node_groups.key
          hosts_count      = node_groups.value.hosts_count
          zone_ids         = node_groups.value.zones_ids
          subnet_ids       = node_groups.value.subnet_ids
          assign_public_ip = node_groups.value.assign_public_ip

          resources {
            resource_preset_id = node_groups.value.resources.resource_preset_id
            disk_size          = node_groups.value.resources.disk_size
            disk_type_id       = node_groups.value.resources.disk_type_id
          }
        }
      }
    }
  }

  maintenance_window {
    type = var.maintenance_window_type
    hour = var.maintenance_window_hour
    day  = var.maintenance_window_day
  }
}
