# Azure Key Vault
resource "azurerm_key_vault" "vault" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
    ip_rules       = var.allowed_ip_addresses
  }

  tags = var.tags
}

# Access policy for the specified service principal
resource "azurerm_key_vault_access_policy" "service_principal" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = var.tenant_id
  object_id    = var.service_principal_object_id

  key_permissions = [
    "Get", "List", "Create", "Delete", "Update",
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete",
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Delete", "Update",
  ]
}

# Optional: Access policy for the current user/deployer
resource "azurerm_key_vault_access_policy" "current_user" {
  count = var.current_user_object_id != null ? 1 : 0

  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = var.tenant_id
  object_id    = var.current_user_object_id

  key_permissions = [
    "Get", "List", "Create", "Delete", "Update",
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete",
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Delete", "Update",
  ]
}
