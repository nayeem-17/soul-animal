output "vm_id" {
  description = "ID of the created virtual machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = azurerm_public_ip.vm_pip.ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "ssh_private_key_secret_name" {
  description = "Name of the Key Vault secret containing the SSH private key"
  value       = azurerm_key_vault_secret.ssh_private_key.name
}

output "ssh_public_key_secret_name" {
  description = "Name of the Key Vault secret containing the SSH public key"
  value       = azurerm_key_vault_secret.ssh_public_key.name
}
