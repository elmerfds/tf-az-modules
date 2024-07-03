resource "azurerm_machine_learning_workspace" "machinelearning_workspace" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  application_insights_id       = var.application_insights_id
  key_vault_id                  = var.key_vault_id
  storage_account_id            = var.storage_account_id
  container_registry_id         = var.container_registry_id
  public_network_access_enabled = var.public_network_access_enabled
  high_business_impact          = var.high_business_impact

  identity {
    type = "SystemAssigned"
  }

  encryption {
    key_vault_id = var.key_vault_id
    key_id       = var.key_id
  }
}