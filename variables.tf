variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "my-project"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
} 
