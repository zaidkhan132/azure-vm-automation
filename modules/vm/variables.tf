variable "env_name" {
  description = "Environment name prefix, e.g., dev-pepsico"
  type        = string
}

variable "vm_index" {
  description = "Index for this VM instance"
  type        = number
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for VM resources"
  type        = string
}

variable "vm_size" {
  description = "The Azure VM size"
  type        = string
}

variable "os_disk_size" {
  description = "OS disk size (in GB)"
  type        = number
}

variable "tags" {
  description = "Tags for the VM"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "Subnet ID for the NIC"
  type        = string
}
