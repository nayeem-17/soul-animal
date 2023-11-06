# rds_project/main.tf

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]

}
# module "rds-aurora" {
#   source  = "terraform-aws-modules/rds-aurora/aws"
#   version = "8.5.0"
# }
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "tax-wizard"
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
  publicly_accessible    = true
  skip_final_snapshot    = true # Set to true if you don't want a final DB snapshot when the instance is deleted
  db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.db_subnet_group_id
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.db_security_group_id]
  tags = {
    Name = "Example RDS"
  }

}

# resource "aws_db_instance" "example_aurora" {
#   allocated_storage   = 20
#   storage_type        = "gp2"
#   engine              = "aurora-postgresql"
#   engine_version      = "13.7"
#   instance_class      = "db.r6g.large"
#   identifier          = "exampledb" # Use a unique identifier for your RDS instance
#   db_name             = "exampledb" # Name of the initial database
#   username            = "dbuser"
#   password            = "dbpassword"
#   publicly_accessible = true

#   skip_final_snapshot    = true # Set to true if you don't want a final DB snapshot when the instance is deleted
#   db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.db_subnet_group_id
#   vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.db_security_group_id]
#   tags = {
#     Name = "Example RDS"
#   }
# }
resource "aws_rds_cluster" "example-1" {
  cluster_identifier = "example-1"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "13.6"
  database_name      = "test"
  master_username    = "test"
  master_password    = "must_be_eight_characters"
  # publicly_accessible = true
  skip_final_snapshot = true

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.db_security_group_id]
  db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.db_subnet_group_id
}

resource "aws_rds_cluster_instance" "example" {
  cluster_identifier  = aws_rds_cluster.example-1.id
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.example-1.engine
  engine_version      = aws_rds_cluster.example-1.engine_version
  publicly_accessible = true
}
