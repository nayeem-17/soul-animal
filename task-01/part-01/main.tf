provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}
# create a vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tf-dev-vpc"
  }
}

#  create a subnet
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dev-subnet-1"
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

# associate subnet with route table 
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route_table.id
}

#  create security group
resource "aws_security_group" "dev-sg" {
  name        = "dev-security-group"
  description = "Allowing inbound/outbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id
  ingress {
    description = "Allow inbound SSH traffic "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow inbound HTTP traffic "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow inbound HTTPS traffic "
    from_port   = 443
    to_port     = 443
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


# create an EC2 instance
resource "aws_instance" "main_server" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  key_name                    = aws_key_pair.example.key_name # Use the key name created above
  subnet_id                   = aws_subnet.subnet-1.id
  vpc_security_group_ids      = [aws_security_group.dev-sg.id]
  associate_public_ip_address = true
  user_data                   = file("setup.sh")
  tags = {
    "Name" = "Main Server"
  }
  # # Connection configuration for provisioners
  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"             # or the username of your instance
  #   private_key = file("aws-test.pem") # Specify the path to your private key
  #   host        = self.public_ip       # Use the public IP of the instance
  # }

  # # Provisioner to copy a file to the instance
  # provisioner "file" {
  #   source      = "/home/kingpin/Documents/soul-animal/app/**" # Path to the local file
  #   destination = "/app/"                                      # Destination path on the remote instance
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "cd app ",
  #     " docker run -d   --name postgres-test   -p 5432:5432   -e POSTGRES_USER=postgres   -e POSTGRES_PASSWORD=pass   -e POSTGRES_DB=demo   postgres",
  #     "docker build -t soul-animal:latest .",
  #     "docker run -d   -p 8000:8000   --name soul-animal   -e DATABASE_URL=postgresql://postgres:pass@172.17.0.1/demo   soul-animal:latest"

  #   ]
  # }
}

# i want to output the main_server public ip
output "main_server_public_ip" {
  value = aws_instance.main_server.public_ip
}
