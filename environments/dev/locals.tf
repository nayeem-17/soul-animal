locals {
  env = terraform.workspace
  tags = {
    Environment = local.env
    ManagedBy   = "Terraform"
    Project     = "soul-animal"
  }
}
