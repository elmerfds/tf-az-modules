resource "azurerm_storage_data_lake_gen2_filesystem" "main" {
  name               = var.name
  storage_account_id = var.storage_account_id
  properties = {
    for key, value in var.properties : key => base64encode(value)
  }

  dynamic "ace" {
    for_each = length(var.ace_permissions) == 0 ? [] : var.ace_permissions
    content {
      id          = ace.value["id"]
      permissions = ace.value["permissions"]
      scope       = ace.value["scope"]
      type        = ace.value["type"]
    }
  }

}

resource "azurerm_storage_data_lake_gen2_path" "other" {
  for_each           = { for folder_path in var.folder_paths : folder_path.path => folder_path }
  path               = each.value.path
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.main.name
  storage_account_id = var.storage_account_id
  resource           = "directory"

  dynamic "ace" {
    for_each = length(each.value.permissions) == 0 ? [] : [for k in each.value.permissions : k]
    content {
      id          = ace.value["id"]
      permissions = ace.value["permissions"]
      scope       = ace.value["scope"]
      type        = ace.value["type"]
    }
  }
}