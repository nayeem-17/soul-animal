variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "identity_name" {
  type        = string
  description = "Name of the user-assigned managed identity"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
