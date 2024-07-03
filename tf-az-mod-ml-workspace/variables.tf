variable "name" {
  description = "(Required) Specifies the name of the Machine Learning Workspace. Changing this forces a new resource to be created."
  type = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the Machine Learning Workspace should exist. Changing this forces a new resource to be created."
  type = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the Resource Group in which the Machine Learning Workspace should exist. Changing this forces a new resource to be created."
}

variable "application_insights_id" {
  description = " (Required) The ID of the Application Insights associated with this Machine Learning Workspace. Changing this forces a new resource to be created."
  type = string
}

variable "key_vault_id" {
  description = "(Required) The ID of key vault associated with this Machine Learning Workspace. Changing this forces a new resource to be created."
  type = string
}

variable "key_id" {
  description = "(Required) The Key Vault URI to access the encryption key."
  type = string
}

variable "storage_account_id" {
  description = "(Required) The ID of the Storage Account associated with this Machine Learning Workspace. Changing this forces a new resource to be created."
  type = string
}

variable "container_registry_id" {
  description = "(Optional) The ID of the container registry associated with this Machine Learning Workspace. Changing this forces a new resource to be created."
  type = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "(Required) Enable public access when this Machine Learning Workspace is behind VNet."
  type = bool
}

variable "high_business_impact" {
  description = "(Optional) Flag to signal High Business Impact (HBI) data in the workspace and reduce diagnostic data collected by the service"
  type = bool
  default = false
}