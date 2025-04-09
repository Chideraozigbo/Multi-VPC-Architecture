output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = var.vpc_name
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = var.create_igw ? aws_route_table.public[0].id : null
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = var.create_igw ? aws_internet_gateway.igw[0].id : null
}