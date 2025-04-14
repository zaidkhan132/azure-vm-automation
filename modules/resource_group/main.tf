resource "azurerm_resource_group" "app_rg" {
  name     = "${var.env_name}-app-rg"
  location = var.location
  tags     = var.tags
}
