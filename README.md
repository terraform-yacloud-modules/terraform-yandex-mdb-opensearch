# Yandex Cloud OpenSearch Terraform module

[![Github tag](https://img.shields.io/github/v/tag/terraform-yacloud-modules/terraform-yandex-mdb-opensearch)](https://github.com/terraform-yacloud-modules/terraform-yandex-mdb-opensearch/releases) [![support opentofu](https://img.shields.io/badge/supports-opentofu-green)](https://opentofu.org/) ![maintenance status](https://img.shields.io/maintenance/yes/2024.svg)

Terraform module which creates Yandex Cloud OpenSearch resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [yandex_mdb_opensearch_cluster.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_opensearch_cluster) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password for the admin user of the OpenSearch cluster. Only used if generate\_admin\_password is false. Must be at least 8 characters long. | `string` | `null` | no |
| <a name="input_dashboard_nodes"></a> [dashboard\_nodes](#input\_dashboard\_nodes) | A map that contains information about OpenSearch dashboard nodes.<br/>    Configuration attributes:<br/>      resources        - (Required) Resources allocated to hosts of this OpenSearch node group.<br/>      hosts\_count      - (Required) Number of hosts in this node group.<br/>      zones\_ids        - (Required) A set of availability zones where hosts of node group may be allocated.<br/>      subnet\_ids       - (Optional) A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.<br/>      assign\_public\_ip - (Optional) Sets whether the hosts should get a public IP address on creation.<br/>      roles            - (Optional) A set of OpenSearch roles assigned to hosts. | <pre>map(object({<br/>    resources = object({<br/>      resource_preset_id = string<br/>      disk_size          = string<br/>      disk_type_id       = string<br/>    })<br/>    hosts_count = number<br/>    zones_ids = optional(<br/>      list(string), ["ru-central1-a", "ru-central1-b", "ru-central1-c"]<br/>    )<br/>    subnet_ids       = optional(list(string), [])<br/>    assign_public_ip = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Enables deletion protection for the OpenSearch cluster. When enabled, prevents accidental deletion of the cluster and its data. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | OpenSearch cluster description | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment environment of the OpenSearch cluster. PRESTABLE is for testing and development, PRODUCTION is for production workloads with higher availability and performance guarantees. | `string` | `"PRODUCTION"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the Yandex Cloud Folder that the resources belongs to.<br/><br/>    Allows to create bucket in different folder.<br/>    It will try to create bucket using IAM-token in provider config, not using access\_key.<br/>    If omitted, folder\_id specified in provider config and access\_key is used. | `string` | `null` | no |
| <a name="input_generate_admin_password"></a> [generate\_admin\_password](#input\_generate\_admin\_password) | If true, a random admin password will be generated for the OpenSearch cluster. If false, the admin\_password variable must be provided. | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Object for setting tags (or labels) for bucket.<br/>    For more information see https://cloud.yandex.com/en/docs/storage/concepts/tags. | `map(string)` | `{}` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | The day of the week for the weekly maintenance window. Only used when maintenance\_window\_type is WEEKLY. | `string` | `null` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | The hour of day in UTC time zone (0-24) for the weekly maintenance window. Only used when maintenance\_window\_type is WEEKLY. | `number` | `null` | no |
| <a name="input_maintenance_window_type"></a> [maintenance\_window\_type](#input\_maintenance\_window\_type) | The type of maintenance window for the OpenSearch cluster. ANYTIME allows maintenance at any time, WEEKLY requires specifying a specific day and hour. | `string` | `"ANYTIME"` | no |
| <a name="input_name"></a> [name](#input\_name) | OpenSearch cluster name | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the OpenSearch cluster belongs. | `string` | n/a | yes |
| <a name="input_opensearch_nodes"></a> [opensearch\_nodes](#input\_opensearch\_nodes) | A map that contains information about OpenSearch cluster nodes.<br/>    Configuration attributes:<br/>      resources        - (Required) Resources allocated to hosts of this OpenSearch node group.<br/>      hosts\_count      - (Required) Number of hosts in this node group.<br/>      zones\_ids        - (Required) A set of availability zones where hosts of node group may be allocated.<br/>      subnet\_ids       - (Optional) A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.<br/>      assign\_public\_ip - (Optional) Sets whether the hosts should get a public IP address on creation.<br/>      roles            - (Optional) A set of OpenSearch roles assigned to hosts. | <pre>map(object({<br/>    resources = object({<br/>      resource_preset_id = string<br/>      disk_size          = string<br/>      disk_type_id       = string<br/>    })<br/>    hosts_count = number<br/>    zones_ids = optional(<br/>      list(string), ["ru-central1-a", "ru-central1-b", "ru-central1-c"]<br/>    )<br/>    subnet_ids       = optional(list(string))<br/>    assign_public_ip = bool<br/>    roles            = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_opensearch_plugins"></a> [opensearch\_plugins](#input\_opensearch\_plugins) | A set of requested OpenSearch plugins. | `list(string)` | `[]` | no |
| <a name="input_opensearch_version"></a> [opensearch\_version](#input\_opensearch\_version) | The version of OpenSearch to deploy. If not specified, the latest available version will be used. | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster. | `list(string)` | `[]` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | The ID of the service account that will be used by the OpenSearch cluster for accessing other Yandex Cloud resources. If not specified, a default service account will be used. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password for the OpenSearch cluster. |
| <a name="output_cluster_created_at"></a> [cluster\_created\_at](#output\_cluster\_created\_at) | The timestamp when the OpenSearch cluster was created in Yandex Cloud. |
| <a name="output_cluster_health"></a> [cluster\_health](#output\_cluster\_health) | The current health status of the OpenSearch cluster (e.g., HEALTHY, DEGRADED, UNHEALTHY). |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID of the OpenSearch cluster |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | The current operational status of the OpenSearch cluster (e.g., RUNNING, STOPPED, STARTING). |
| <a name="output_dashboard_fqdns"></a> [dashboard\_fqdns](#output\_dashboard\_fqdns) | A list of fully qualified domain names (FQDNs) of the OpenSearch Dashboard nodes for accessing the web interface. |
| <a name="output_hosts"></a> [hosts](#output\_hosts) | A list of all hosts in the OpenSearch cluster, including their FQDNs, IP addresses, and node types. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
