output "vm_public_ip" {
  value = module.vm.vm_public_ip
}

output "tls_private_key" {
  value     = module.vm.tls_private_key
  sensitive = true
}

output "tls_public_key" {
  value = module.vm.tls_public_key
}
