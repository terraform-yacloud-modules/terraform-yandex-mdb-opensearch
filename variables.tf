#
# yandex cloud coordinates
#
variable "folder_id" {
  description = <<EOF
    The ID of the Yandex Cloud Folder that the resources belongs to.

    Allows to create bucket in different folder.
    It will try to create bucket using IAM-token in provider config, not using access_key.
    If omitted, folder_id specified in provider config and access_key is used.
  EOF
  type        = string
  default     = null
}

#
# naming
#
variable "name" {
  description = "OpenSearch cluster name"
  type        = string
}

variable "description" {
  description = "OpenSearch cluster description"
  type        = string
  default     = ""
}

variable "labels" {
  description = <<EOF
    Object for setting tags (or labels) for bucket.
    For more information see https://cloud.yandex.com/en/docs/storage/concepts/tags.
  EOF
  type        = map(string)
  default     = {}
}

#
# OpenSearch common settings
#
variable "environment" {
  description = "The deployment environment of the OpenSearch cluster. PRESTABLE is for testing and development, PRODUCTION is for production workloads with higher availability and performance guarantees."
  type        = string
  validation {
    condition = contains([
      "PRESTABLE", "PRODUCTION"
    ], var.environment)
    error_message = "Available values are \"PRESTABLE\", \"PRODUCTION\" (case sensitive)."
  }
  default = "PRODUCTION"
}

variable "service_account_id" {
  description = "The ID of the service account that will be used by the OpenSearch cluster for accessing other Yandex Cloud resources. If not specified, a default service account will be used."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Enables deletion protection for the OpenSearch cluster. When enabled, prevents accidental deletion of the cluster and its data."
  type        = bool
  default     = false
}

#
# OpenSearch cluster network
#
variable "network_id" {
  description = "ID of the network, to which the OpenSearch cluster belongs."
  type        = string
}

variable "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster."
  type        = list(string)
  default     = []
}

#
# OpenSearch config
#
variable "opensearch_version" {
  description = "The version of OpenSearch to deploy. If not specified, the latest available version will be used."
  type        = string
  default     = null
}

variable "generate_admin_password" {
  description = "If true, a random admin password will be generated for the OpenSearch cluster. If false, the admin_password variable must be provided."
  type        = bool
  default     = true
}
variable "admin_password" {
  description = "The password for the admin user of the OpenSearch cluster. Only used if generate_admin_password is false. Must be at least 8 characters long."
  type        = string
  default     = null
}

variable "opensearch_plugins" {
  description = "A set of requested OpenSearch plugins."
  type        = list(string)
  default     = []
}

#
# OpenSearch nodes
#
variable "opensearch_nodes" {
  description = <<EOF
    A map that contains information about OpenSearch cluster nodes.
    Configuration attributes:
      resources        - (Required) Resources allocated to hosts of this OpenSearch node group.
      hosts_count      - (Required) Number of hosts in this node group.
      zones_ids        - (Required) A set of availability zones where hosts of node group may be allocated.
      subnet_ids       - (Optional) A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.
      assign_public_ip - (Optional) Sets whether the hosts should get a public IP address on creation.
      roles            - (Optional) A set of OpenSearch roles assigned to hosts.
  EOF
  nullable    = false
  type = map(object({
    resources = object({
      resource_preset_id = string
      disk_size          = string
      disk_type_id       = string
    })
    hosts_count = number
    zones_ids = optional(
      list(string), ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
    )
    subnet_ids       = optional(list(string))
    assign_public_ip = bool
    roles            = optional(list(string))
  }))
  default = {}
}

#
# Dashboard nodes
#
variable "dashboard_nodes" {
  description = <<EOF
    A map that contains information about OpenSearch dashboard nodes.
    Configuration attributes:
      resources        - (Required) Resources allocated to hosts of this OpenSearch node group.
      hosts_count      - (Required) Number of hosts in this node group.
      zones_ids        - (Required) A set of availability zones where hosts of node group may be allocated.
      subnet_ids       - (Optional) A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.
      assign_public_ip - (Optional) Sets whether the hosts should get a public IP address on creation.
      roles            - (Optional) A set of OpenSearch roles assigned to hosts.
  EOF
  nullable    = false
  type = map(object({
    resources = object({
      resource_preset_id = string
      disk_size          = string
      disk_type_id       = string
    })
    hosts_count = number
    zones_ids = optional(
      list(string), ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
    )
    subnet_ids       = optional(list(string), [])
    assign_public_ip = bool
  }))
  default = {}
}

#
# OpenSearch maintenance
#
variable "maintenance_window_type" {
  description = "The type of maintenance window for the OpenSearch cluster. ANYTIME allows maintenance at any time, WEEKLY requires specifying a specific day and hour."
  type        = string
  validation {
    condition = contains([
      "ANYTIME", "WEEKLY"
    ], var.maintenance_window_type)
    error_message = "Available values are \"ANYTIME\", \"WEEKLY\" (case sensitive)."
  }
  default = "ANYTIME"
}

variable "maintenance_window_hour" {
  description = "The hour of day in UTC time zone (0-24) for the weekly maintenance window. Only used when maintenance_window_type is WEEKLY."
  type        = number
  validation {
    condition     = var.maintenance_window_hour >= 0 && var.maintenance_window_hour <= 24
    error_message = "The variable must be a number between 0 and 24 (inclusive)."
  }
  default = null
}

variable "maintenance_window_day" {
  description = "The day of the week for the weekly maintenance window. Only used when maintenance_window_type is WEEKLY."
  type        = string
  validation {
    condition = contains([
      "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"
    ], var.maintenance_window_day)
    error_message = "Available values are \"MON\", \"TUE\", \"WED\", \"THU\", \"FRI\", \"SAT\", \"SUN\" (case sensitive)."
  }
  default = null
}
