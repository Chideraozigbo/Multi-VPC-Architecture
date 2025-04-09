output "instance_id" {
  description = "The ID of the instance"
  value       = aws_instance.instance.id
}

output "private_ip" {
  description = "The private IP of the instance"
  value       = aws_instance.instance.private_ip
}

output "public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.instance.public_ip
}