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
  default     = "Standard_DS1_v2"
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

# variable "user_assigned_identity_id" {
#   description = "ID of the user assigned managed identity"
#   type        = string
# }

variable "custom_data" {
  description = "Custom data script for VM initialization"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
