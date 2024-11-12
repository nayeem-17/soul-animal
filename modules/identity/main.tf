# User Assigned Managed Identity
resource "azurerm_user_assigned_identity" "managed_identity" {
  name                = var.identity_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Optional: Role assignments for the managed identity
resource "azurerm_role_assignment" "identity_roles" {
  for_each = var.role_assignments

  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.managed_identity.principal_id
} 
