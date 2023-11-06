# ec2_project/main.tf
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}
# create a vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tf-dev-vpc"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dev-subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "dev-subnet-2"
  }
}

resource "aws_subnet" "subnet-3" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c" # Choose a different availability zone
  map_public_ip_on_launch = false        # This ensures instances in this subnet do not get public IPs

  tags = {
    Name = "dev-subnet-3"
  }
}

# create internet gateway
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
}
# create a route table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }
}

# route table association for two subnets
resource "aws_route_table_association" "rta-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "rta-2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "rta-3" {
  subnet_id      = aws_subnet.subnet-3.id
  route_table_id = aws_route_table.route_table.id
}

# create a db subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name = "example"
  subnet_ids = [
    aws_subnet.subnet-2.id,
    aws_subnet.subnet-1.id
  ]
}
#  create security group
resource "aws_security_group" "dev-db-sg" {
  name        = "dev-security-group"
  description = "Allowing inbound/outbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id
  ingress {
    description = "Allow inbound HTTP traffic "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # create a ingress block for ssh
  ingress {
    description = "Allow inbound ssh traffic "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inbound ssh traffic "
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Dev Security group"
  }
}
resource "aws_security_group" "postgres_sg" {
  name        = "postgres_sg"
  description = "Allow access to PostgreSQL"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description = "Allow PostgreSQL traffic"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # Restrict access as needed 
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PostgreSQL Security Group"
  }
}
