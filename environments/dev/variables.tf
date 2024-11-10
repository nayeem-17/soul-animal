variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "project" {
  type        = string
  description = "Project name"
  default     = "soul-animal"
}

variable "resource_group_name" {
  type        = string
  default     = "kml_rg_main-53d51aa891a24648"
  description = "Resource group name in your Azure subscription."
}
