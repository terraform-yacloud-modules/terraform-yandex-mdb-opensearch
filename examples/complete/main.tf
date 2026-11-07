data "yandex_client_config" "client" {}

provider "yandex" {
}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  blank_name = "vpc-opensearch-complete"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-d"]

  private_subnets = [["10.5.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "opensearch" {
  source = "../../"

  name                    = "test-opensearch-complete"
  description             = "Complete OpenSearch cluster example"
  environment             = "PRESTABLE"
  network_id              = module.network.vpc_id
  folder_id               = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  generate_admin_password = true

  labels = {
    environment = "test"
    project     = "terraform-yandex-mdb-opensearch"
  }

  service_account_id     = null
  deletion_protection    = false
  security_group_ids     = []
  disk_encryption_key_id = null

  opensearch_version = "3.9"
  opensearch_plugins = ["analysis-icu"]

  opensearch_config = {
    fielddata_cache_size         = "30%"
    http_max_initial_line_length = "8kb"
    max_clause_count             = 2048
    reindex_remote_whitelist     = "reindex.example.com:9200"
    search_max_buckets           = 10000
  }

  audit_log = {
    compliance_enabled         = true
    log_authenticated_requests = true
    log_index_events           = true
    log_search_queries         = true
  }

  access = {
    data_transfer = true
  }

  opensearch_nodes = {
    group0 = {
      resources = {
        resource_preset_id = "s2.micro"
        disk_size          = "10737418240"
        disk_type_id       = "network-ssd"
      }
      hosts_count      = 1
      zones_ids        = ["ru-central1-d"]
      subnet_ids       = [module.network.private_subnets_ids[0]]
      assign_public_ip = true
      roles            = ["data", "manager"]
      disk_size_autoscaling = {
        disk_size_limit           = 21474836480
        planned_usage_threshold   = 0
        emergency_usage_threshold = 95
      }
    }
  }

  dashboard_nodes = {
    dashboard0 = {
      resources = {
        resource_preset_id = "s2.micro"
        disk_size          = "10737418240"
        disk_type_id       = "network-ssd"
      }
      hosts_count      = 1
      zones_ids        = ["ru-central1-d"]
      subnet_ids       = [module.network.private_subnets_ids[0]]
      assign_public_ip = true
    }
  }

  maintenance_window_type = "WEEKLY"
  maintenance_window_hour = 2
  maintenance_window_day  = "SUN"

  timeouts = {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
