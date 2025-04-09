variable "requester_vpc_id" {
  description = "ID of the requester VPC"
  type        = string
}

variable "accepter_vpc_id" {
  description = "ID of the accepter VPC"
  type        = string
}

variable "requester_vpc_name" {
  description = "Name of the requester VPC"
  type        = string
}

variable "accepter_vpc_name" {
  description = "Name of the accepter VPC"
  type        = string
}

variable "requester_cidr_block" {
  description = "CIDR block of the requester VPC"
  type        = string
}

variable "accepter_cidr_block" {
  description = "CIDR block of the accepter VPC"
  type        = string
}

variable "requester_route_table_ids" {
  description = "List of route table IDs in the requester VPC"
  type        = list(string)
}

variable "accepter_route_table_ids" {
  description = "List of route table IDs in the accepter VPC"
  type        = list(string)
}

variable "auto_accept" {
  description = "Whether to auto-accept the peering connection"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}