variable "env_name" {
  description = "Environment name for naming."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Subnet prefixes for the VNET."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "resource_group_name" {
  description = "Resource group for the network."
  type        = string
}

variable "tags" {
  description = "Tags for network resources."
  type        = map(string)
  default     = {}
}
