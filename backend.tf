terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstate${random_string.suffix.result}"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
} 
