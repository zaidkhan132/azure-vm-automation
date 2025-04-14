variable "env_name" {
  description = "Environment name to prefix resource names."
  type        = string
}

variable "location" {
  description = "Azure region for resources."
  type        = string
}

variable "tags" {
  description = "Tags for the resource group."
  type        = map(string)
  default     = {}
}
