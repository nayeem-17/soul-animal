variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B2s"
}

variable "subnet_id" {
  description = "ID of the subnet where the VM will be placed"
  type        = string
}

variable "admin_username" {
  description = "Username for the VM admin account"
  type        = string
  default     = "azureuser"
}

variable "key_vault_id" {
  description = "ID of the Key Vault to store SSH keys"
  type        = string
}

variable "key_vault_policy_id" {
  description = "ID of the Key Vault access policy to depend on"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
