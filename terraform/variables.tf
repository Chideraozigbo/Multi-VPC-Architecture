variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "multi-vpc-architecture"
}

variable "cidr_blocks" {
  description = "List of CIDR blocks for VPCs"
  type        = list(string)
  default     = ["10.10.0.0/16", "10.100.0.0/16"]
}

variable "vpc_names" {
  description = "List of VPC names"
  type        = list(string)
  default     = ["Ingestion-VPC", "Analytics-VPC"]
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0274f4b62b6ae3bd5"
}

variable "key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
  default     = "cyberdom-key"
}