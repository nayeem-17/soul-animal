# backend.tf

terraform {
  backend "s3" {
    bucket = "tax-wizard"
    key    = "vpc.tfstate"
    region = "us-east-1" # Adjust for your region
  }
}
