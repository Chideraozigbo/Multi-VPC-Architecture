variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "ingress_rules" {
  description = "Map of ingress rules to create"
  type        = map(object({
    cidr_ipv4    = string
    from_port    = optional(number)
    to_port      = optional(number)
    ip_protocol  = string
    description  = optional(string)
  }))
  default     = {}
}

variable "egress_rules" {
  description = "Map of egress rules to create"
  type        = map(object({
    cidr_ipv4    = string
    from_port    = optional(number)
    to_port      = optional(number)
    ip_protocol  = string
    description  = optional(string)
  }))
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}