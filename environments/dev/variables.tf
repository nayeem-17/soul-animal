variable "location" {
  type        = string
  description = "Azure region for all resources"
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "my-project"
} 
