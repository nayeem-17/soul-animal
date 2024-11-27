# Add this at the top of the file
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${local.env}-rg"
  location = var.location
}

data "azurerm_resource_group" "rg" {
  # name = var.resource_group_name
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

# # Create managed identity
# module "identity" {
#   source = "../../modules/identity"

#   identity_name       = "${local.env}-vm-identity"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.rg.name

#   role_assignments = {
#     "vm_contributor" = {
#       scope                = data.azurerm_resource_group.rg.id
#       role_definition_name = "Reader"
#     }
#   }

#   tags = local.tags
# }

# Read init script
locals {
  init_script = file("${path.module}/files/init.sh")
}

# Add Linux VM
module "vm" {
  source = "../../modules/vm"

  vm_name             = "${local.env}-vm"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = module.network.public_subnet_id
  admin_username      = var.vm_admin_username
  vm_size             = var.vm_size
  # user_assigned_identity_id = module.identity.identity_id
  custom_data = local.init_script

  tags = local.tags
}

