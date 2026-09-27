# ---------------------------------------------------------
# VPC
# ---------------------------------------------------------

resource "aws_vpc" "inventory_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "cloudops-inventory-vpc"
    Project = "CloudOps-Inventory-System"
  }
}


# ---------------------------------------------------------
# Internet Gateway
# ---------------------------------------------------------

resource "aws_internet_gateway" "inventory_igw" {
  vpc_id = aws_vpc.inventory_vpc.id

  tags = {
    Name    = "cloudops-inventory-igw"
    Project = "CloudOps-Inventory-System"
  }
}


# ---------------------------------------------------------
# Public Subnet
# ---------------------------------------------------------

resource "aws_subnet" "inventory_public_subnet" {
  vpc_id                  = aws_vpc.inventory_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "cloudops-inventory-public-subnet"
    Project = "CloudOps-Inventory-System"
  }
}


# ---------------------------------------------------------
# Route Table
# ---------------------------------------------------------

resource "aws_route_table" "inventory_public_rt" {
  vpc_id = aws_vpc.inventory_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inventory_igw.id
  }

  tags = {
    Name    = "cloudops-inventory-public-rt"
    Project = "CloudOps-Inventory-System"
  }
}


# ---------------------------------------------------------
# Route Table Association
# ---------------------------------------------------------

resource "aws_route_table_association" "inventory_public_association" {
  subnet_id      = aws_subnet.inventory_public_subnet.id
  route_table_id = aws_route_table.inventory_public_rt.id
}


# ---------------------------------------------------------
# Security Group
# ---------------------------------------------------------

resource "aws_security_group" "inventory_web_sg" {
  name        = "cloudops-inventory-web-sg"
  description = "Security group for CloudOps Inventory EC2"
  vpc_id      = aws_vpc.inventory_vpc.id

  # SSH
  ingress {
    description = "SSH from administrator IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  # HTTP
  ingress {
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "cloudops-inventory-web-sg"
    Project = "CloudOps-Inventory-System"
  }
}


# ---------------------------------------------------------
# EC2 Instance
# ---------------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "inventory_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.inventory_public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.inventory_web_sg.id
  ]

  key_name = var.key_name

  tags = {
    Name        = "cloudops-inventory-server"
    Project     = "CloudOps-Inventory-System"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}