output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.vault.id
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.vault.vault_uri
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.vault.name
}

output "service_principal_access_policy_id" {
  description = "ID of the service principal's access policy"
  value       = azurerm_key_vault_access_policy.service_principal.id
}
