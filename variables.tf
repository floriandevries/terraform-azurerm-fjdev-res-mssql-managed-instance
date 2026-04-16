variable "license_type" {
  type        = string
  description = "What type of license the Managed Instance will use. Possible values are `LicenseIncluded` and `BasePrice`."

  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "The `license_type` must be either `LicenseIncluded` or `BasePrice`."
  }
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "name" {
  type        = string
  description = "The name of the SQL Managed Instance. This needs to be globally unique within Azure. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the SQL Managed Instance. Changing this forces a new resource to be created."
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for the SQL Managed Instance. Possible values are `GP_Gen4`, `GP_Gen5`, `GP_Gen8IM`, `GP_Gen8IH`, `BC_Gen4`, `BC_Gen5`, `BC_Gen8IM` or `BC_Gen8IH`."

  validation {
    condition     = contains(["GP_Gen4", "GP_Gen5", "GP_Gen8IM", "GP_Gen8IH", "BC_Gen4", "BC_Gen5", "BC_Gen8IM", "BC_Gen8IH"], var.sku_name)
    error_message = "The `sku_name` must be one of `GP_Gen4`, `GP_Gen5`, `GP_Gen8IM`, `GP_Gen8IH`, `BC_Gen4`, `BC_Gen5`, `BC_Gen8IM` or `BC_Gen8IH`."
  }
}

variable "storage_size_in_gb" {
  type        = number
  description = <<DESCRIPTION
Maximum storage space for the SQL Managed instance. This should be a multiple of 32 (GB).
> Note: The maximum storage size varies depending on the service tier and hardware generation. For General Purpose Next-gen instances, the maximum is 32,768 GB (32 TB), while Business Critical instances support up to 16,384 GB (16 TB). Refer to [Azure SQL Managed Instance resource limits](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/resource-limits) for detailed information.
DESCRIPTION
}

variable "subnet_id" {
  type        = string
  description = "The subnet resource id that the SQL Managed Instance will be associated with."
}

variable "vcores" {
  type        = number
  description = "Number of cores that should be assigned to the SQL Managed Instance. Values can be `8`, `16`, or `24` for Gen4 SKUs, or `4`, `6`, `8`, `10`, `12`, `16`, `20`, `24`, `32`, `40`, `48`, `56`, `64`, `80`, `96` or `128` for Gen5 SKUs."

  validation {
    condition     = contains([4, 6, 8, 10, 12, 16, 20, 24, 32, 40, 48, 56, 64, 80, 96, 128], var.vcores)
    error_message = "The `vcores` must be one of `8`, `16`, or `24` for Gen4 SKUs, or `4`, `6`, `8`, `10`, `12`, `16`, `20`, `32`, `40`, `48`, `56`, `64`, `80`, `96` or `128` for Gen5 SKUs."
  }
}

variable "administrator_login" {
  type        = string
  default     = null
  description = "The administrator login name for the new SQL Managed Instance. Changing this forces a new resource to be created."
}

variable "administrator_login_password" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The password associated with the administrator_login user. Needs to comply with Azure's [Password Policy](https://msdn.microsoft.com/library/ms161959.aspx).
> Note: Unless `azure_active_directory_administrator.azuread_authentication_only_enabled` is set to `true`, `administrator_login` and `administrator_login_password` are required.
DESCRIPTION
}

variable "azure_active_directory_administrator" {
  type = object({
    login_username                      = string
    object_id                           = string
    principal_type                      = string
    azuread_authentication_only_enabled = optional(bool, false)
    tenant_id                           = optional(string)
  })
  default     = null
  description = <<DESCRIPTION
An `azure_active_directory_administrator` block as defined below.
- `login_username`                      - The login username of the Azure AD Administrator of this SQL Managed Instance.
- `object_id`                           - The object id of the Azure AD Administrator of this SQL Managed Instance.
- `principal_type`                      - The principal type of the Azure AD Administrator of this SQL Managed Instance. Possible values are `Application`, `Group`, `User`.
- `azuread_authentication_only_enabled` - (Optional) Specifies whether only Azure AD authentication can be used to log in to this SQL Managed Instance. When `true`, the `administrator_login` and `administrator_login_password` properties can be omitted.
- `tenant_id`                           - (Optional) The tenant id of the Azure AD Administrator of this SQL Managed Instance. Should be specified if the Azure AD Administrator is homed in a different tenant to the SQL Managed Instance.
DESCRIPTION
}

variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "Specifies how the SQL Managed Instance will be collated. Changing this forces a new resource to be created."
}

variable "database_format" {
  type        = string
  default     = "SQLServer2022"
  description = <<DESCRIPTION
Specifies the internal format of the SQL Managed Instance databases specific to the SQL engine version. Possible values are `AlwaysUpToDate` and `SQLServer2022`.
> Note: Changing `database_format` from `AlwaysUpToDate` to `SQLServer2022` forces a new SQL Managed Instance to be created.
DESCRIPTION

  validation {
    condition     = contains(["AlwaysUpToDate", "SQLServer2022"], var.database_format)
    error_message = "The `database_format` must be either `AlwaysUpToDate` or `SQLServer2022`."
  }
}

variable "dns_zone_partner_id" {
  type        = string
  default     = null
  description = "The ID of the SQL Managed Instance which will share the DNS zone. This is a prerequisite for creating an `azurerm_sql_managed_instance_failover_group`. Setting this after creation forces a new resource to be created."
}

variable "general_purpose_v2_enabled" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
Specifies whether the SQL Managed Instance should use the Next-gen General Purpose service tier.
> Note: The `general_purpose_v2_enabled` property can only be set to true when using a General Purpose (`GP_*`) SKU.
DESCRIPTION
}

variable "hybrid_secondary_usage" {
  type        = string
  default     = "Active"
  description = "Specifies the hybrid secondary usage for disaster recovery of the SQL Managed Instance. Possible values are `Active` and `Passive`."

  validation {
    condition     = contains(["Active", "Passive"], var.hybrid_secondary_usage)
    error_message = "The `hybrid_secondary_usage` must be either `Active` or `Passive`."
  }
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default     = null
  description = <<DESCRIPTION
An `identity` block as defined below.
- `type` - Specifies the type of Managed Service Identity that should be configured on this SQL Managed Instance. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`.
- `identity_ids` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this SQL Managed Instance. Required when `type` includes `UserAssigned`.
> Note: The assigned `principal_id` and `tenant_id` can be retrieved after the identity `type` has been set to `SystemAssigned` and SQL Managed Instance has been created.
DESCRIPTION
}

variable "maintenance_configuration_name" {
  type        = string
  default     = "SQL_Default"
  description = "The name of the Public Maintenance Configuration window to apply to the SQL Managed Instance. Valid values include `SQL_Default` or an Azure Location in the format `SQL_{Location}_MI_{Size}` (for example `SQL_EastUS_MI_1`)."
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = <<DESCRIPTION
The Minimum TLS Version. Valid values include `1.0`, `1.1`, `1.2`.
> Note: Azure Services will require TLS 1.2+ by August 2025, please see this [announcement](https://azure.microsoft.com/en-us/updates/v2/update-retirement-tls1-0-tls1-1-versions-azure-services/) for more.
DESCRIPTION

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "The `minimum_tls_version` must be either `1.0`, `1.1`, or `1.2`."
  }
}

variable "proxy_override" {
  type        = string
  default     = "Default"
  description = "Specifies how the SQL Managed Instance will be accessed. Possible values are `Default`, `Proxy`, and `Redirect`."

  validation {
    condition     = contains(["Default", "Proxy", "Redirect"], var.proxy_override)
    error_message = "The `proxy_override` must be either `Default`, `Proxy`, or `Redirect`."
  }
}

variable "public_data_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Is the public data endpoint enabled?"
}

variable "service_principal_type" {
  type        = string
  default     = null
  description = "The service principal type. The only possible value is `SystemAssigned`."
}

variable "storage_account_type" {
  type        = string
  default     = "GRS"
  description = "Specifies the storage account type used to store backups for this database. Possible values are `GRS`, `GZRS`, `LRS`, and `ZRS`."

  validation {
    condition     = contains(["GRS", "GZRS", "LRS", "ZRS"], var.storage_account_type)
    error_message = "The `storage_account_type` must be either `GRS`, `GZRS`, `LRS`, or `ZRS`."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "timezone_id" {
  type        = string
  default     = "UTC"
  description = "The TimeZone ID that the SQL Managed Instance will be operating in. Changing this forces a new resource to be created."
}

variable "zone_redundant_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the SQL Managed Instance is zone redundant."
}
