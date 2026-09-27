output "vpc_id" {
  description = "ID of the CloudOps Inventory VPC"
  value       = aws_vpc.inventory_vpc.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.inventory_public_subnet.id
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.inventory_web_sg.id
}

output "instance_id" {
  description = "ID of the inventory EC2 instance"
  value       = aws_instance.inventory_server.id
}

output "public_ip" {
  description = "Public IP address of the inventory server"
  value       = aws_instance.inventory_server.public_ip
}

output "public_dns" {
  description = "Public DNS name of the inventory server"
  value       = aws_instance.inventory_server.public_dns
}