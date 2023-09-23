# backend.tf

terraform {
  backend "s3" {
    bucket = "soul-animal-tf"
    key    = "rds.tfstate"
    region = "us-east-1" # Adjust for your region
  }
}
