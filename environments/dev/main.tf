# Add this at the top of the file
data "azurerm_client_config" "current" {}

# data "azurerm_resource_group" "rg" {
#   name = var.resource_group_name
# }

resource "azurerm_resource_group" "rg" {
  name     = "${local.env}-rg"
  location = var.location
}

data "azurerm_resource_group" "rg" {
  name = azurerm_resource_group.rg.name
}

module "network" {
  source = "../../modules/network"

  vnet_name           = "${local.env}-vnet"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  public_subnet_prefix  = "10.0.1.0/24"
  private_subnet_prefix = "10.0.2.0/24"

  tags = local.tags
}

# Add Managed Identity
module "identity" {
  source = "../../modules/identity"

  identity_name       = "${local.env}-identity"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  role_assignments = {
    "key_vault_secrets" = {
      scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_resource_group.rg.name}"
      role_definition_name = "Reader"
    }
  }

  tags = local.tags
}

# Add Key Vault module before VM module
module "key_vault" {
  source = "../../modules/keyvault"

  key_vault_name              = "${local.env}-kv"
  location                    = var.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  service_principal_object_id = data.azurerm_client_config.current.object_id

  tags = local.tags
}

# # Add Linux VM
# module "vm" {
#   source = "../../modules/vm"

#   vm_name             = "${local.env}-vm"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.rg.name
#   subnet_id           = module.network.public_subnet_id

#   # These should be provided in terraform.tfvars
#   admin_username = var.vm_admin_username
#   vm_size        = var.vm_size

#   # Add Key Vault references
#   key_vault_id        = module.key_vault.key_vault_id
#   key_vault_policy_id = module.key_vault.service_principal_access_policy_id

#   tags = local.tags
# }
