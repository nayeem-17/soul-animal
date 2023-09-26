# backend.tf

terraform {
  backend "s3" {
    bucket = "soul-animal-tf"
    key    = "vpc.tfstate"
    region = "us-east-1" # Adjust for your region
  }
}
