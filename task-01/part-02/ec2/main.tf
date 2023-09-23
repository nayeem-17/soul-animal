# ec2_project/main.tf
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}

data "terraform_remote_state" "rds" {
  backend = "s3"
  config = {
    bucket = "soul-animal-tf"
    key    = "rds.tfstate"
    region = "us-east-1" # Adjust for your region
  }
}

# Create an SSH key pair
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key to a file in the current directory
resource "local_file" "private_key" {
  filename = "aws-test.pem"
  content  = tls_private_key.example.private_key_pem
}

# Save the public key to a file in the current directory
resource "local_file" "public_key" {
  filename = "public_key.pub"
  content  = tls_private_key.example.public_key_openssh
}

# Create an AWS Key Pair
resource "aws_key_pair" "example" {
  key_name   = "aws-test" # The name of the key pair
  public_key = tls_private_key.example.public_key_openssh
}


resource "aws_instance" "myec2" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  key_name                    = aws_key_pair.example.key_name # Use the key name created above
  subnet_id                   = data.terraform_remote_state.rds.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.rds.outputs.vpc_security_group_id]
  associate_public_ip_address = true
  tags = {
    "Name" = "Main Server"
  }
  user_data                   = <<-EOF
    #!/bin/bash
    echo "export DATABASE_URL=${data.terraform_remote_state.rds.outputs.rds_endpoint}" >> /etc/environment
    # ... Other setup and application deployment ...
    sudo apt-get update -y
    sudo apt-get install -y docker-compose
    sudo apt install git -y
    echo $DATABASE_URL
    docker run -d   \
        -p 80:8000   \
        --name soul-animal   \
        -e DATABASE_URL="$DATABASE_URL"   \
        n0x41yeem/soul-animal:latest
    EOF
  user_data_replace_on_change = true
}