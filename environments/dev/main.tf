module "network" {
  source = "../../modules/network"

  vnet_name           = "dev-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  subnets = {
    "subnet1" = "10.0.1.0/24"
    "subnet2" = "10.0.2.0/24"
  }

  tags = local.tags
}

resource "azurerm_resource_group" "rg" {
  name     = "dev-rg"
  location = var.location
  tags     = local.tags
}

locals {
  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }
} 
