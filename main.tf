resource "azurerm_mssql_managed_instance" "sqlmi" {
  license_type                   = var.license_type
  location                       = var.location
  name                           = var.name
  resource_group_name            = var.resource_group_name
  sku_name                       = var.sku_name
  storage_size_in_gb             = var.storage_size_in_gb
  subnet_id                      = var.subnet_id
  vcores                         = var.vcores
  administrator_login            = var.administrator_login
  administrator_login_password   = var.administrator_login_password
  collation                      = var.collation
  database_format                = var.database_format
  dns_zone_partner_id            = var.dns_zone_partner_id
  hybrid_secondary_usage         = var.hybrid_secondary_usage
  maintenance_configuration_name = var.maintenance_configuration_name
  minimum_tls_version            = var.minimum_tls_version
  proxy_override                 = var.proxy_override
  public_data_endpoint_enabled   = var.public_data_endpoint_enabled
  service_principal_type         = var.service_principal_type
  storage_account_type           = var.storage_account_type
  tags                           = var.tags
  timezone_id                    = var.timezone_id
  zone_redundant_enabled         = var.zone_redundant_enabled

  dynamic "azure_active_directory_administrator" {
    for_each = var.azure_active_directory_administrator != null ? [var.azure_active_directory_administrator] : []

    content {
      login_username                      = azure_active_directory_administrator.value.login_username
      object_id                           = azure_active_directory_administrator.value.object_id
      principal_type                      = azure_active_directory_administrator.value.principal_type
      azuread_authentication_only_enabled = azure_active_directory_administrator.value.azuread_authentication_only_enabled
      tenant_id                           = azure_active_directory_administrator.value.tenant_id
    }
  }
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}
