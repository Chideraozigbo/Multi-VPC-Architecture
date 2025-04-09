variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool
  default     = false
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "route_table_id" {
  description = "Route table ID to associate with the subnet"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}