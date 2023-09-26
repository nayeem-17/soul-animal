# rds_project/main.tf

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]

}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "soul-animal-tf"
    key    = "vpc.tfstate"
    region = "us-east-1" # Adjust for your region
  }
}


resource "aws_db_instance" "example" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "13.7"
  instance_class         = "db.t3.micro"
  identifier             = "exampledb" # Use a unique identifier for your RDS instance
  db_name                = "exampledb" # Name of the initial database
  username               = "dbuser"
  password               = "dbpassword"
  skip_final_snapshot    = true # Set to true if you don't want a final DB snapshot when the instance is deleted
  db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.db_subnet_group_id
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.db_security_group_id]
  tags = {
    Name = "Example RDS"
  }

}

