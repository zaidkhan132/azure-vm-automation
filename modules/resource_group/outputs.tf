output "resource_group_name" {
  description = "Name of the application resource group."
  value       = azurerm_resource_group.app_rg.name
}
