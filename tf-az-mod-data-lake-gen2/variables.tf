variable "name" {
  type        = string
  description = "Name of ADLS FS to create"
}

variable "storage_account_id" {
  type        = string
  description = "ID of storage account to create ADLS in"
}

variable "properties" {
  type        = map(string)
  description = "Map of properties"
  default     = {}
}

variable "ace_permissions" {
  type        = list(map(string))
  description = "List of ADLS FS permissions"
  default     = []
}

variable "folder_paths" {
  type = list(object({
    path        = string
    permissions = any
  }))
  description = "List of ADLS folders configuration to create"
  default     = []
}
