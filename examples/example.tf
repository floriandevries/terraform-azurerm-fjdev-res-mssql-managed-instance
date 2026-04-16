module "mssql_managed_instance" {
  source = "git::https://github.com/Cegeka-Hybrid-Cloud/pc-cc-terraform-azurerm-cgk-res-mssql-managed-instance.git?ref=v1.0.0"

  name                = "managedsqlinstance"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  license_type       = "BasePrice"
  sku_name           = "GP_Gen5"
  storage_size_in_gb = 32
  subnet_id          = azurerm_subnet.example.id
  vcores             = 4

  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"
}
