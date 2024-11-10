output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = azurerm_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = azurerm_subnet.private.id
}

output "public_nsg_id" {
  description = "The ID of the public subnet NSG"
  value       = azurerm_network_security_group.public_nsg.id
}

output "private_nsg_id" {
  description = "The ID of the private subnet NSG"
  value       = azurerm_network_security_group.private_nsg.id
}
