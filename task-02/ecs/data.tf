data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "tax-wizard"
    key    = "vpc.tfstate"
    region = "us-east-1" # Adjust for your region
  }
}
