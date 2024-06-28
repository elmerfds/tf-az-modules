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
| [azurerm_data_factory.data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory) | resource |
| [azurerm_private_endpoint.data_factory_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adf_rg_name"></a> [adf\_rg\_name](#input\_adf\_rg\_name) | (Required) The name of the resource group in which to create the Data Factory. | `string` | n/a | yes |
| <a name="input_adfi_pes"></a> [adfi\_pes](#input\_adfi\_pes) | (Optional) List of private endpoint objects to create for the ADF instance | `any` | `[]` | no |
| <a name="input_azure_devops_configuration"></a> [azure\_devops\_configuration](#input\_azure\_devops\_configuration) | Azure DevOps configuration for ADF CI/CD integration with ADO. | <pre>object({<br>  account_name    = string<br>  branch_name     = string<br>  project_name    = string<br>  repository_name = string<br>  root_folder     = string<br>  tenant_id       = string<br>})</pre> | `null` | no |
| <a name="input_github_configuration"></a> [github\_configuration](#input\_github\_configuration) | GitHub configuration for ADF CI/CD integration. | <pre>object({<br>  account_name    = string<br>  branch_name     = string<br>  git_url         = string<br>  repository_name = string<br>  root_folder     = string<br>})</pre> | `null` | no |
| <a name="input_identity_config"></a> [identity\_config](#input\_identity\_config) | (Optional) Config block - a group of values containing the identity config, {identity\_type = [SystemAssigned \| UserAssigned \| SystemAssigned, UserAssigned], identity\_ids = [<AAD Object Id>]}. Config block defaults to null. | `any` | <pre>{<br>  "identity_ids": [],<br>  "identity_type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_managed_virtual_network_enabled"></a> [managed\_virtual\_network\_enabled](#input\_managed\_virtual\_network\_enabled) | (Optional) Is Managed Virtual Network enabled? | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Data Factory. Changing this forces a new resource to be created. Must be globally unique. See the https://learn.microsoft.com/en-gb/azure/data-factory/naming-rules for all restrictions. | `string` | n/a | yes |
| <a name="input_public_network_enabled"></a> [public\_network\_enabled](#input\_public\_network\_enabled) | (Optional) Is the Data Factory visible to the public network?, defaults to false. | `bool` | `false` | no |
| <a name="input_purview_id"></a> [purview\_id](#input\_purview\_id) | (Optional) Specifies the ID of the purview account resource associated with the Data Factory. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Resource ID of the ADF instance. |
<!-- END_TF_DOCS -->

## Pipelines

| Name | Description |
|------|-------------|
| data-factory-version | On commit to the main branch, this pipeline updates the version number of the tag |
| data-factory-validate | Triggered on pull request and execute terraform validate on module |

## Code Example
```hcl
#================================================================================================
# Data Factory Module Call
#================================================================================================
module "data_factories" {
  source      = "git::https://azaidemo@dev.azure.com/azaidemo/terraform-modules/_git/tf-az-mod-adf?ref=main"
  for_each    = { for data_factory in var.data_factories : data_factory.name => data_factory }
  name        = format("%s-%s", local.label, each.value.name)
  adf_rg_name = azurerm_resource_group.spoke_rgs[each.value.resource_group_key].name
  location    = var.location
  
  tags        = merge(local.tags, { "Deployment-date" = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp()) })

  # Optional: Add Azure DevOps configuration
  azure_devops_configuration = {
    account_name    = "your-ado-account"
    branch_name     = "main"
    project_name    = "your-project"
    repository_name = "your-repo"
    root_folder     = "/"
    tenant_id       = "your-tenant-id"
  }

  # Optional: Add GitHub configuration
  github_configuration = {
    account_name    = "your-github-account"
    branch_name     = "main"
    git_url         = "https://github.com"
    repository_name = "your-repo"
    root_folder     = "/"
  }
}