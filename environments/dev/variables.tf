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
