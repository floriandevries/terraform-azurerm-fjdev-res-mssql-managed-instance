output "dns_zone" {
  description = "The DNS Zone where the SQL Managed Instance is located."
  value       = azurerm_mssql_managed_instance.sqlmi.dns_zone
}

output "fqdn" {
  description = "The fully qualified domain name of the Azure Managed SQL Instance."
  value       = azurerm_mssql_managed_instance.sqlmi.fqdn
}

output "id" {
  description = "The SQL Managed Instance ID."
  value       = azurerm_mssql_managed_instance.sqlmi.id
}
