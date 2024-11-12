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

output "tls_private_key" {
  description = "Generated private key for SSH access"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "tls_public_key" {
  description = "Generated public key for SSH access"
  value       = tls_private_key.ssh.public_key_openssh
}
