<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-cgk-res-mssql-managed-instance

Terraform Resource module that manages a Microsoft SQL Azure Managed Instance.

> [!NOTE]
> All arguments including the administrator login and password will be stored in the raw state as plain-text. [Read more about sensitive data in state](https://www.terraform.io/docs/state/sensitive-data.html).

> [!NOTE]
> SQL Managed Instance needs permission to read Azure Active Directory when configuring the AAD administrator. [Read more about provisioning AAD administrators](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql#provision-azure-ad-admin-sql-managed-instance).

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_managed_instance.sqlmi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance) | resource |



## Example Usage
```hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | What type of license the Managed Instance will use. Possible values are `LicenseIncluded` and `BasePrice`. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the SQL Managed Instance. This needs to be globally unique within Azure. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the SQL Managed Instance. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for the SQL Managed Instance. Possible values are `GP_Gen4`, `GP_Gen5`, `GP_Gen8IM`, `GP_Gen8IH`, `BC_Gen4`, `BC_Gen5`, `BC_Gen8IM` or `BC_Gen8IH`. | `string` | n/a | yes |
| <a name="input_storage_size_in_gb"></a> [storage\_size\_in\_gb](#input\_storage\_size\_in\_gb) | Maximum storage space for the SQL Managed instance. This should be a multiple of 32 (GB).<br/>> Note: The maximum storage size varies depending on the service tier and hardware generation. For General Purpose Next-gen instances, the maximum is 32,768 GB (32 TB), while Business Critical instances support up to 16,384 GB (16 TB). Refer to [Azure SQL Managed Instance resource limits](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/resource-limits) for detailed information. | `number` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet resource id that the SQL Managed Instance will be associated with. | `string` | n/a | yes |
| <a name="input_vcores"></a> [vcores](#input\_vcores) | Number of cores that should be assigned to the SQL Managed Instance. Values can be `8`, `16`, or `24` for Gen4 SKUs, or `4`, `6`, `8`, `10`, `12`, `16`, `20`, `24`, `32`, `40`, `48`, `56`, `64`, `80`, `96` or `128` for Gen5 SKUs. | `number` | n/a | yes |
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login name for the new SQL Managed Instance. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The password associated with the administrator\_login user. Needs to comply with Azure's [Password Policy](https://msdn.microsoft.com/library/ms161959.aspx).<br/>> Note: Unless `azure_active_directory_administrator.azuread_authentication_only_enabled` is set to `true`, `administrator_login` and `administrator_login_password` are required. | `string` | `null` | no |
| <a name="input_azure_active_directory_administrator"></a> [azure\_active\_directory\_administrator](#input\_azure\_active\_directory\_administrator) | An `azure_active_directory_administrator` block as defined below.<br/>- `login_username`                      - The login username of the Azure AD Administrator of this SQL Managed Instance.<br/>- `object_id`                           - The object id of the Azure AD Administrator of this SQL Managed Instance.<br/>- `principal_type`                      - The principal type of the Azure AD Administrator of this SQL Managed Instance. Possible values are `Application`, `Group`, `User`.<br/>- `azuread_authentication_only_enabled` - (Optional) Specifies whether only Azure AD authentication can be used to log in to this SQL Managed Instance. When `true`, the `administrator_login` and `administrator_login_password` properties can be omitted.<br/>- `tenant_id`                           - (Optional) The tenant id of the Azure AD Administrator of this SQL Managed Instance. Should be specified if the Azure AD Administrator is homed in a different tenant to the SQL Managed Instance. | <pre>object({<br/>    login_username                      = string<br/>    object_id                           = string<br/>    principal_type                      = string<br/>    azuread_authentication_only_enabled = optional(bool, false)<br/>    tenant_id                           = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | Specifies how the SQL Managed Instance will be collated. Changing this forces a new resource to be created. | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| <a name="input_database_format"></a> [database\_format](#input\_database\_format) | Specifies the internal format of the SQL Managed Instance databases specific to the SQL engine version. Possible values are `AlwaysUpToDate` and `SQLServer2022`.<br/>> Note: Changing `database_format` from `AlwaysUpToDate` to `SQLServer2022` forces a new SQL Managed Instance to be created. | `string` | `"SQLServer2022"` | no |
| <a name="input_dns_zone_partner_id"></a> [dns\_zone\_partner\_id](#input\_dns\_zone\_partner\_id) | The ID of the SQL Managed Instance which will share the DNS zone. This is a prerequisite for creating an `azurerm_sql_managed_instance_failover_group`. Setting this after creation forces a new resource to be created. | `string` | `null` | no |
| <a name="input_hybrid_secondary_usage"></a> [hybrid\_secondary\_usage](#input\_hybrid\_secondary\_usage) | Specifies the hybrid secondary usage for disaster recovery of the SQL Managed Instance. Possible values are `Active` and `Passive`. | `string` | `"Active"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | An `identity` block as defined below.<br/>- `type` - Specifies the type of Managed Service Identity that should be configured on this SQL Managed Instance. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`.<br/>- `identity_ids` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this SQL Managed Instance. Required when `type` includes `UserAssigned`.<br/>> Note: The assigned `principal_id` and `tenant_id` can be retrieved after the identity `type` has been set to `SystemAssigned` and SQL Managed Instance has been created. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_maintenance_configuration_name"></a> [maintenance\_configuration\_name](#input\_maintenance\_configuration\_name) | The name of the Public Maintenance Configuration window to apply to the SQL Managed Instance. Valid values include `SQL_Default` or an Azure Location in the format `SQL_{Location}_MI_{Size}` (for example `SQL_EastUS_MI_1`). | `string` | `"SQL_Default"` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The Minimum TLS Version. Valid values include `1.0`, `1.1`, `1.2`.<br/>> Note: Azure Services will require TLS 1.2+ by August 2025, please see this [announcement](https://azure.microsoft.com/en-us/updates/v2/update-retirement-tls1-0-tls1-1-versions-azure-services/) for more. | `string` | `"1.2"` | no |
| <a name="input_proxy_override"></a> [proxy\_override](#input\_proxy\_override) | Specifies how the SQL Managed Instance will be accessed. Possible values are `Default`, `Proxy`, and `Redirect`. | `string` | `"Default"` | no |
| <a name="input_public_data_endpoint_enabled"></a> [public\_data\_endpoint\_enabled](#input\_public\_data\_endpoint\_enabled) | Is the public data endpoint enabled? | `bool` | `false` | no |
| <a name="input_service_principal_type"></a> [service\_principal\_type](#input\_service\_principal\_type) | The service principal type. The only possible value is `SystemAssigned`. | `string` | `null` | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | Specifies the storage account type used to store backups for this database. Possible values are `GRS`, `GZRS`, `LRS`, and `ZRS`. | `string` | `"GRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_timezone_id"></a> [timezone\_id](#input\_timezone\_id) | The TimeZone ID that the SQL Managed Instance will be operating in. Changing this forces a new resource to be created. | `string` | `"UTC"` | no |
| <a name="input_zone_redundant_enabled"></a> [zone\_redundant\_enabled](#input\_zone\_redundant\_enabled) | Specifies whether the SQL Managed Instance is zone redundant. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_zone"></a> [dns\_zone](#output\_dns\_zone) | The DNS Zone where the SQL Managed Instance is located. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name of the Azure Managed SQL Instance. |
| <a name="output_id"></a> [id](#output\_id) | The SQL Managed Instance ID. |

## Modules

No modules.

<!-- END_TF_DOCS -->