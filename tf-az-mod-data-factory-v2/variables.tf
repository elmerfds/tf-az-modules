variable "name" {
  description = "(Required) Specifies the name of the Data Factory. Changing this forces a new resource to be created. Must be globally unique. See the https://learn.microsoft.com/en-gb/azure/data-factory/naming-rules for all restrictions."
  type        = string
}

variable "adf_rg_name" {
  description = "(Required) The name of the resource group in which to create the Data Factory."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "managed_virtual_network_enabled" {
  description = "(Optional) Is Managed Virtual Network enabled?"
  type        = bool
  default     = true
}

variable "public_network_enabled" {
  description = "(Optional) Is the Data Factory visible to the public network?, defaults to false."
  type        = bool
  default     = false
}

variable "azure_devops_configuration" {
  description = "Azure DevOps configuration for ADF CI/CD integration with ADO."
  type = object({
    account_name    = string
    branch_name     = string
    project_name    = string
    repository_name = string
    root_folder     = string
    tenant_id       = string
  })
  default = null
}

variable "github_configuration" {
  description = "GitHub configuration for ADF CI/CD integration."
  type = object({
    account_name    = string
    branch_name     = string
    git_url         = string
    repository_name = string
    root_folder     = string
  })
  default = null
}

variable "tags" {
  description = "(Required) A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "identity_config" {
  description = "(Optional) Config block - a group of values containing the identity config, {identity_type = [SystemAssigned | UserAssigned | SystemAssigned, UserAssigned], identity_ids = [<AAD Object Id>]}. Config block defaults to null."
  default = {
    identity_type = "SystemAssigned"
    identity_ids  = []
  }
  type = any
}

variable "adfi_pes" {
  description = "(Optional) List of private endpoint objects to create for the ADF instance"
  type        = any
  default     = []
}

variable "purview_id" {
  description = "(Optional) Specifies the ID of the purview account resource associated with the Data Factory."
  type        = string
  default     = null
}