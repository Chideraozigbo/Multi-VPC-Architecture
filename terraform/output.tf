output "vpc_a_id" {
  description = "ID of VPC A"
  value       = module.vpc_a.vpc_id
}

output "vpc_b_id" {
  description = "ID of VPC B"
  value       = module.vpc_b.vpc_id
}

output "public_instance_public_ip" {
  description = "Public IP of the public instance in VPC A"
  value       = module.public_a_instance.public_ip
}

output "private_a_instance_private_ip" {
  description = "Private IP of the private instance in VPC A"
  value       = module.private_a_instance.private_ip
}

output "private_b_instance_private_ip" {
  description = "Private IP of the private instance in VPC B"
  value       = module.private_b_instance.private_ip
}

output "peering_connection_id" {
  description = "VPC Peering Connection ID"
  value       = module.vpc_peering.peering_connection_id
}

output "peering_connection_status" {
  description = "VPC Peering Connection Status"
  value       = module.vpc_peering.peering_connection_status
}
