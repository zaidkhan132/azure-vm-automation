variable "env_name" {
  description = "Environment name to prefix resource names, e.g., dev-pepsico"
  type        = string
}

variable "location" {
  description = "Azure region for deployment."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name where resources are deployed."
  type        = string
}

variable "vm_size" {
  description = "The VM size to use."
  type        = string
}

variable "os_disk_size" {
  description = "OS disk size in GB."
  type        = number
}

variable "tags" {
  description = "Common tags to be assigned to resources."
  type        = map(string)
  default     = {}
}

variable "vm_index" {
  description = "Index for this VM instance"
  type        = number
}

variable "backend_sa" {
  default = "azuredpbackendsa"
}

variable "backend_container" {
    default = "tfstate"
}
