variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "service_principal_object_id" {
  description = "Object ID of the service principal that needs access to the Key Vault"
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of the current user that needs access to the Key Vault"
  type        = string
  default     = null
}

variable "allowed_ip_addresses" {
  description = "List of IP addresses that are allowed to access the Key Vault"
  type        = list(string)
  default     = []
}

variable "secrets" {
  description = "Map of secrets to create in the Key Vault"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 
