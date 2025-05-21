data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  private_subnets = [["10.4.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "opensearch" {
  source = "../../"

  name                    = "test-opensearch"
  environment             = "PRESTABLE"
  network_id              = module.network.vpc_id
  folder_id               = data.yandex_client_config.client.folder_id
  generate_admin_password = true

  opensearch_nodes = {
    group0 = {
      resources = {
        resource_preset_id = "s2.micro"
        disk_size          = "10737418240"
        disk_type_id       = "network-ssd"
      }
      hosts_count      = 1
      zones_ids        = ["ru-central1-a"]
      subnet_ids       = [module.network.private_subnets_ids[0]]
      assign_public_ip = true
      roles            = ["data", "manager"]
    }
  }

  dashboard_nodes = {}

  maintenance_window_type = "WEEKLY"
  maintenance_window_hour = 2
  maintenance_window_day  = "SUN"
}
