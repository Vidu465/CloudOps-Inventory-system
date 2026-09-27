variable "aws_region" {
  description = "The AWS region where the infrastructure will be created."
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}

variable "admin_cidr" {
  description = "Public IPv4 address allowed to connect through SSH"
  type        = string
}