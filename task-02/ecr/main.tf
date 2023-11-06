provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "tax-wizard-ecr"
}
