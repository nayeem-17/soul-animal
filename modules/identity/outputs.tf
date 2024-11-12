output "identity_id" {
  description = "ID of the managed identity"
  value       = azurerm_user_assigned_identity.managed_identity.id
}

output "principal_id" {
  description = "Principal ID of the managed identity"
  value       = azurerm_user_assigned_identity.managed_identity.principal_id
}

output "client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.managed_identity.client_id
}

output "tenant_id" {
  description = "Tenant ID of the managed identity"
  value       = azurerm_user_assigned_identity.managed_identity.tenant_id
}
