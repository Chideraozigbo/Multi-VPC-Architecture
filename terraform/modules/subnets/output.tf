output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.subnet.id
}

output "subnet_cidr_block" {
  description = "The CIDR block of the subnet"
  value       = aws_subnet.subnet.cidr_block
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = var.subnet_name
}