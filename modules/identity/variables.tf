variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "identity_name" {
  description = "Name of the managed identity"
  type        = string
}

variable "role_assignments" {
  description = "Map of role assignments for the managed identity"
  type = map(object({
    scope                = string
    role_definition_name = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 
