resource "azurerm_resource_group" "rg" {
  name     = "${local.env}-rg"
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "../../modules/network"

  vnet_name           = "${local.env}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  public_subnet_prefix  = "10.0.1.0/24"
  private_subnet_prefix = "10.0.2.0/24"

  tags = local.tags
}
