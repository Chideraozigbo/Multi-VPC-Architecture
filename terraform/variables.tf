variable "project-name" {
    type = string
    default = "multi-vpc-architecture"
  
}

variable "cidr-blocks" {
    type = list(string)
    default = [ "10.10.0.0/16", "10.100.0.0/16" ]
  
}

variable "vpc-name" {
    type = list(string)
    default = [ "Ingestion-VPC", "Analytics-VPC" ]
  
}

variable "environment" {
    type = string
    default = "production"
  
}

variable "ami_id" {
    type = string
    default = "ami-0274f4b62b6ae3bd5"
  
}

variable "key_name" {
    type = string
    default = "cyberdom-key"
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
  
}