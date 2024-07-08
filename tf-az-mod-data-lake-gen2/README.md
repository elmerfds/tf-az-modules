<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_data_lake_gen2_filesystem.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [azurerm_storage_data_lake_gen2_path.other](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_path) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ace_permissions"></a> [ace\_permissions](#input\_ace\_permissions) | List of ADLS FS permissions | `list(map(string))` | `[]` | no |
| <a name="input_folder_paths"></a> [folder\_paths](#input\_folder\_paths) | List of ADLS folders configuration to create | <pre>list(object({<br>    path        = string<br>    permissions = any<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of ADLS FS to create | `string` | n/a | yes |
| <a name="input_properties"></a> [properties](#input\_properties) | Map of properties | `map(string)` | `{}` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | ID of storage account to create ADLS in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Lake Gen2 File System |
<!-- END_TF_DOCS -->

## Pipelines

| Name | Description |
|------|-------------|
| data-lake-gen2-version | On commit to the main branch, this pipeline updates the version number of the tag |
| data-lake-gen2-validate | Triggered on pull request and execute terraform validate on module |

## Code Example 
```
#================================================================================================
# Data Lakes Module Call
#================================================================================================
module "data_lake_gen2" {
  source             = "git::https://azaidemo@dev.azure.com/azaidemo/terraform-modules/_git/tf-az-mod-data-lake-gen2?ref=main"
  for_each           = { for data_lake in var.data_lakes : data_lake.name => data_lake }
  name               = format("%s-%s", local.label, each.value.name)
  storage_account_id = module.storage_accounts[each.value.storage_account_key].storage_account_id
}
```

```
#================================================================================================
# Data Lakes tfvars
#================================================================================================
data_lakes = [
  {
    name                = "adslg2-01"
    storage_account_key = "synwssa01"
  }
]
```