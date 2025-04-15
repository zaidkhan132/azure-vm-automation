provider "azurerm" {
  features {}
resource_group {
      prevent_deletion_if_contains_resources = false
    }
}

module "resource_group" {
  source   = "./modules/resource_group"
  env_name = var.env_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "./modules/network"
  env_name            = var.env_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24"]
  tags                = var.tags
}

module "vm" {
  source              = "./modules/vm"
  env_name            = var.env_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id
  vm_size             = var.vm_size
  os_disk_size        = var.os_disk_size
  tags                = var.tags
  vm_index = var.vm_index
}
