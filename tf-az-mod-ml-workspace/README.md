<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_machine_learning_workspace.machinelearning_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | (Required) The ID of the Application Insights associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_container_registry_id"></a> [container\_registry\_id](#input\_container\_registry\_id) | (Optional) The ID of the container registry associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_high_business_impact"></a> [high\_business\_impact](#input\_high\_business\_impact) | (Optional) Flag to signal High Business Impact (HBI) data in the workspace and reduce diagnostic data collected by the service | `bool` | `false` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | (Required) The Key Vault URI to access the encryption key. | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | (Required) The ID of key vault associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the Machine Learning Workspace should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Required) Enable public access when this Machine Learning Workspace is behind VNet. | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the name of the Resource Group in which the Machine Learning Workspace should exist. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | (Required) The ID of the Storage Account associated with this Machine Learning Workspace. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Sample code
```terraform
module "example_ml_workspace" {
  source                        = "../tf-az-mod-ml-workspace/"
  name                          = "Example_ML_Workspace"
  location                      = "UK South"
  resource_group_name           = "Example_ML_Workspace-RG"
  application_insights_id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Insights/components/instance1"
  key_vault_id                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.KeyVault/vaults/vault1"
  key_id                        = "https://example-keyvault.vault.azure.net/keys/example/fdf067c93bbb4b22bff4d8b7a9a56217"
  storage_account_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.Storage/storageAccounts/myaccount"
  container_registry_id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.ContainerRegistry/registries/myregistry1"
  public_network_access_enabled = false
  high_business_impact          = false
}

```
<!-- END_TF_DOCS -->