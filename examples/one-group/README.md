# Example OpenSearch

## Usage

To run this example you need to execute:

```bash
export YC_FOLDER_ID='folder_id'
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git | v1.0.0 |
| <a name="module_opensearch"></a> [opensearch](#module\_opensearch) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
