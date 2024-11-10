resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  tags = var.tags
}

resource "azurerm_user_assigned_identity" "identity" {
  name                = var.identity_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}
