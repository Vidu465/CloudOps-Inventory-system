# Architecture

## Week 2 Architecture

```text
User
  |
  | HTTP
  v
Internet
  |
  v
AWS Internet Gateway
  |
  v
VPC
  |
  v
Subnet
  |
  v
EC2 Instance
  |
  v
Nginx
  |
  v
index.html