resource "azurerm_data_factory" "data_factory" {
  name                = var.name
  resource_group_name = var.adf_rg_name
  location            = var.location

  managed_virtual_network_enabled = var.managed_virtual_network_enabled
  public_network_enabled          = var.public_network_enabled

  dynamic "identity" {
    for_each = var.identity_config != null ? ["iterate"] : []
    content {
      type         = lookup(var.identity_config, "identity_type", null)
      identity_ids = lookup(var.identity_config, "identity_ids", [])
    }
  }

  dynamic "vsts_configuration" {
    for_each = toset(var.azure_devops_configuration == null ? [] : [var.azure_devops_configuration])

    content {
      account_name    = vsts_configuration.value.account_name
      branch_name     = vsts_configuration.value.branch_name
      project_name    = vsts_configuration.value.project_name
      repository_name = vsts_configuration.value.repository_name
      root_folder     = vsts_configuration.value.root_folder
      tenant_id       = vsts_configuration.value.tenant_id
    }
  }

  purview_id = var.purview_id

  tags = var.tags
  lifecycle {
    ignore_changes = [tags["Deployment-date"], tags["catalogUri"]]
  }

}


resource "azurerm_private_endpoint" "data_factory_pe" {
  for_each            = { for my_adfi_pe in var.adfi_pes : my_adfi_pe.name => my_adfi_pe }
  name                = try(each.value.name, "${var.name}-pe")
  location            = each.value.location
  resource_group_name = try(each.value.pe_resource_group_name, var.adf_rg_name)
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = try(each.value.psc_name, "${var.name}-psc")
    private_connection_resource_id = azurerm_data_factory.data_factory.id
    is_manual_connection           = try(each.value.psc_is_manual_connection, false)
    subresource_names              = each.value.psc_subresource_names
  }

  dynamic "private_dns_zone_group" {
    for_each = try(each.value.private_dns_zone_group, [])
    content {
      name                 = private_dns_zone_group.value.pdzg_name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [tags["Deployment-date"]]
  }
}