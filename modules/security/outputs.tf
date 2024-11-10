output "key_vault_id" {
  description = "ID of the created Key Vault"
  value       = azurerm_key_vault.kv.id
}

output "key_vault_uri" {
  description = "URI of the created Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}

output "identity_id" {
  description = "ID of the created managed identity"
  value       = azurerm_user_assigned_identity.identity.id
}

output "identity_principal_id" {
  description = "Principal ID of the created managed identity"
  value       = azurerm_user_assigned_identity.identity.principal_id
}
