variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "public_subnet_prefix" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "private_subnet_prefix" {
  type        = string
  description = "CIDR block for the private subnet"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
  default     = {}
}
