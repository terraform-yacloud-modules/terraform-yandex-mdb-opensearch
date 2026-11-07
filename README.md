# Yandex Cloud OpenSearch Terraform module

[![Github tag](https://img.shields.io/github/v/tag/terraform-yacloud-modules/terraform-yandex-mdb-opensearch)](https://github.com/terraform-yacloud-modules/terraform-yandex-mdb-opensearch/releases) [![support opentofu](https://img.shields.io/badge/supports-opentofu-green)](https://opentofu.org/) ![maintenance status](https://img.shields.io/maintenance/yes/2025.svg)

Terraform module which creates Yandex Cloud OpenSearch resources.

Official resource docs: [yandex_mdb_opensearch_cluster](https://yandex.cloud/ru/docs/terraform/resources/mdb_opensearch_cluster).

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.229.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.229.0 |

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
| <a name="input_access"></a> [access](#input\_access) | Access to the OpenSearch cluster from other Yandex Cloud services.<br/>    Configuration attributes:<br/>      data\_transfer - (Optional) Enable access to Data Transfer. | <pre>object({<br/>    data_transfer = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password for the admin user of the OpenSearch cluster. Only used if generate\_admin\_password is false. Must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character. | `string` | `null` | no |
| <a name="input_audit_log"></a> [audit\_log](#input\_audit\_log) | OpenSearch audit log settings.<br/>    If omitted, audit logging settings are not managed by the module. | <pre>object({<br/>    compliance_enabled         = optional(bool, false)<br/>    log_authenticated_requests = optional(bool, false)<br/>    log_backup_operations      = optional(bool, false)<br/>    log_bad_headers            = optional(bool, false)<br/>    log_data_modifications     = optional(bool, false)<br/>    log_index_events           = optional(bool, false)<br/>    log_index_maintenance      = optional(bool, false)<br/>    log_index_metadata_access  = optional(bool, false)<br/>    log_monitoring_checks      = optional(bool, false)<br/>    log_request_body           = optional(bool, false)<br/>    log_search_queries         = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_dashboard_nodes"></a> [dashboard\_nodes](#input\_dashboard\_nodes) | A map that contains information about OpenSearch dashboard nodes.<br/>    Configuration attributes:<br/>      resources        - (Required) Resources allocated to hosts of this OpenSearch node group.<br/>      hosts\_count      - (Required) Number of hosts in this node group. Must be at least 1.<br/>      zones\_ids        - (Required) A set of availability zones where hosts of node group may be allocated.<br/>      subnet\_ids       - (Optional) A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.<br/>      assign\_public\_ip - (Optional) Sets whether the hosts should get a public IP address on creation. | <pre>map(object({<br/>    resources = object({<br/>      resource_preset_id = string<br/>      disk_size          = string<br/>      disk_type_id       = string<br/>    })<br/>    hosts_count = number<br/>    zones_ids = optional(<br/>      list(string), ["ru-central1-a", "ru-central1-b", "ru-central1-d"]<br/>    )<br/>    subnet_ids       = optional(list(string), [])<br/>    assign_public_ip = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Enables deletion protection for the OpenSearch cluster. When enabled, prevents accidental deletion of the cluster and its data. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | OpenSearch cluster description | `string` | `""` | no |
| <a name="input_disk_encryption_key_id"></a> [disk\_encryption\_key\_id](#input\_disk\_encryption\_key\_id) | ID of the KMS key for cluster disk encryption. If not specified, encryption will be disabled. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment environment of the OpenSearch cluster. PRESTABLE is for testing and development, PRODUCTION is for production workloads with higher availability and performance guarantees. | `string` | `"PRODUCTION"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the Yandex Cloud Folder that the resources belongs to.<br/><br/>    Allows to create bucket in different folder.<br/>    It will try to create bucket using IAM-token in provider config, not using access\_key.<br/>    If omitted, folder\_id specified in provider config and access\_key is used. | `string` | `null` | no |
| <a name="input_generate_admin_password"></a> [generate\_admin\_password](#input\_generate\_admin\_password) | If true, a random admin password will be generated for the OpenSearch cluster. If false, the admin\_password variable must be provided. | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Object for setting tags (or labels) for bucket.<br/>    For more information see https://cloud.yandex.com/en/docs/storage/concepts/tags. | `map(string)` | `{}` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | The day of the week for the weekly maintenance window. Only used when maintenance\_window\_type is WEEKLY. | `string` | `null` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | The hour of day in UTC time zone (0-24) for the weekly maintenance window. Only used when maintenance\_window\_type is WEEKLY. | `number` | `null` | no |
| <a name="input_maintenance_window_type"></a> [maintenance\_window\_type](#input\_maintenance\_window\_type) | The type of maintenance window for the OpenSearch cluster. ANYTIME allows maintenance at any time, WEEKLY requires specifying a specific day and hour. | `string` | `"ANYTIME"` | no |
| <a name="input_name"></a> [name](#input\_name) | OpenSearch cluster name | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the OpenSearch cluster belongs. | `string` | n/a | yes |
| <a name="input_opensearch_config"></a> [opensearch\_config](#input\_opensearch\_config) | OpenSearch server configuration settings.<br/>    Configuration attributes:<br/>      fielddata\_cache\_size         - (Optional) Maximum size of the field data cache. Can be an absolute value (for example, 8GB) or a percentage of the node heap (for example, 50%).<br/>      http\_max\_initial\_line\_length - (Optional) Maximum length allowed for HTTP URLs in the initial request line (for example, 4kb).<br/>      max\_clause\_count             - (Optional) Maximum product of fields and terms that are queryable simultaneously.<br/>      reindex\_remote\_whitelist     - (Optional) Comma-separated list of remote hosts allowed for reindexing, in <host\_address>:<port> format.<br/>      search\_max\_buckets           - (Optional) Maximum number of aggregation buckets allowed in a single response. | <pre>object({<br/>    fielddata_cache_size         = optional(string)<br/>    http_max_initial_line_length = optional(string)<br/>    max_clause_count             = optional(number)<br/>    reindex_remote_whitelist     = optional(string)<br/>    search_max_buckets           = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_opensearch_nodes"></a> [opensearch\_nodes](#input\_opensearch\_nodes) | A map that contains information about OpenSearch cluster nodes.<br/>    Configuration attributes:<br/>      resources             - (Required) Resources allocated to hosts of this OpenSearch node group.<br/>      hosts\_count           - (Required) Number of hosts in this node group. Must be at least 1.<br/>      zones\_ids             - (Required) A set of availability zones where hosts of node group may be allocated.<br/>      subnet\_ids            - (Optional) A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.<br/>      assign\_public\_ip      - (Optional) Sets whether the hosts should get a public IP address on creation.<br/>      roles                 - (Optional) A set of OpenSearch roles assigned to hosts. Available roles are data, manager, warm and ingest.<br/>      disk\_size\_autoscaling - (Optional) Automatic disk size expansion settings.<br/>        disk\_size\_limit           - Maximum disk size in bytes. Exactly one of disk\_size\_limit or disk\_size\_gb\_limit must be set.<br/>        disk\_size\_gb\_limit        - Maximum disk size in GiB. Exactly one of disk\_size\_limit or disk\_size\_gb\_limit must be set.<br/>        planned\_usage\_threshold   - Storage usage percentage that triggers expansion during the maintenance window. Provider v0.244.0 accepts only 0 (older provider versions accept 0-100).<br/>        emergency\_usage\_threshold - Storage usage percentage that triggers immediate expansion. | <pre>map(object({<br/>    resources = object({<br/>      resource_preset_id = string<br/>      disk_size          = string<br/>      disk_type_id       = string<br/>    })<br/>    hosts_count = number<br/>    zones_ids = optional(<br/>      list(string), ["ru-central1-a", "ru-central1-b", "ru-central1-d"]<br/>    )<br/>    subnet_ids       = optional(list(string))<br/>    assign_public_ip = bool<br/>    roles            = optional(list(string))<br/>    disk_size_autoscaling = optional(object({<br/>      disk_size_limit           = optional(number)<br/>      disk_size_gb_limit        = optional(number)<br/>      planned_usage_threshold   = optional(number, 0)<br/>      emergency_usage_threshold = optional(number, 0)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_opensearch_plugins"></a> [opensearch\_plugins](#input\_opensearch\_plugins) | A set of requested OpenSearch plugins. | `list(string)` | `[]` | no |
| <a name="input_opensearch_version"></a> [opensearch\_version](#input\_opensearch\_version) | The version of OpenSearch to deploy. If not specified, the latest available version will be used. | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster. | `list(string)` | `[]` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | The ID of the service account that will be used by the OpenSearch cluster for accessing other Yandex Cloud resources. If not specified, a default service account will be used. | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout settings for cluster operations | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password for the OpenSearch cluster. |
| <a name="output_cluster_created_at"></a> [cluster\_created\_at](#output\_cluster\_created\_at) | The timestamp when the OpenSearch cluster was created in Yandex Cloud. |
| <a name="output_cluster_health"></a> [cluster\_health](#output\_cluster\_health) | The current health status of the OpenSearch cluster (e.g., HEALTHY, DEGRADED, UNHEALTHY). |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID of the OpenSearch cluster |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | The current operational status of the OpenSearch cluster (e.g., RUNNING, STOPPED, STARTING). |
| <a name="output_dashboard_fqdns"></a> [dashboard\_fqdns](#output\_dashboard\_fqdns) | A list of fully qualified domain names (FQDNs) of the OpenSearch Dashboard nodes for accessing the web interface. |
| <a name="output_disk_encryption_key_id"></a> [disk\_encryption\_key\_id](#output\_disk\_encryption\_key\_id) | ID of the KMS key used for cluster disk encryption. |
| <a name="output_hosts"></a> [hosts](#output\_hosts) | A list of all hosts in the OpenSearch cluster, including their FQDNs, IP addresses, and node types. |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
