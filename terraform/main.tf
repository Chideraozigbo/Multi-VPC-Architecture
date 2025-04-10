locals {
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# VPC A
module "vpc_a" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/vpc?ref=v1.0.0"

  cidr_block = var.cidr_blocks[0]
  vpc_name   = var.vpc_names[0]
  create_igw = true
  tags       = local.tags
}

# VPC B
module "vpc_b" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/vpc?ref=v1.0.0"

  cidr_block = var.cidr_blocks[1]
  vpc_name   = var.vpc_names[1]
  create_igw = false
  tags       = local.tags
}

# Subnets for VPC A
module "vpc_a_public_subnet" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/subnets?ref=v1.0.0"

  vpc_id                  = module.vpc_a.vpc_id
  cidr_block              = "10.10.0.0/28"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
  subnet_name             = "${module.vpc_a.vpc_name}-public"
  route_table_id          = module.vpc_a.public_route_table_id
  tags                    = local.tags
}

module "vpc_a_private_subnet" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/subnets?ref=v1.0.0"

  vpc_id                  = module.vpc_a.vpc_id
  cidr_block              = "10.10.0.16/28"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false
  subnet_name             = "${module.vpc_a.vpc_name}-private"
  route_table_id          = module.vpc_a.private_route_table_id
  tags                    = local.tags
}

# Subnet for VPC B
module "vpc_b_private_subnet" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/subnets?ref=v1.0.0"

  vpc_id                  = module.vpc_b.vpc_id
  cidr_block              = "10.100.0.0/28"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = false
  subnet_name             = "${module.vpc_b.vpc_name}-private"
  route_table_id          = module.vpc_b.private_route_table_id
  tags                    = local.tags
}

# Security Groups
module "vpc_a_public_sg" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/security?ref=v1.0.0"

  vpc_id              = module.vpc_a.vpc_id
  security_group_name = "${module.vpc_a.vpc_name}-public-sg"
  description         = "Allow SSH inbound traffic from the internet and all protocols outbound traffic"

  ingress_rules = {
    ssh = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      description = "Allow SSH from anywhere"
    }
  }

  egress_rules = {
    all = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "-1"
    }
  }

  tags = local.tags
}

module "vpc_a_private_sg" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/security?ref=v1.0.0"

  vpc_id              = module.vpc_a.vpc_id
  security_group_name = "${module.vpc_a.vpc_name}-private-sg"
  description         = "Allow all traffic from both VPCs"

  ingress_rules = {
    vpc_a = {
      cidr_ipv4   = var.cidr_blocks[0]
      ip_protocol = "-1"
      description = "Allow all protocol from VPC A"
    },
    vpc_b = {
      cidr_ipv4   = var.cidr_blocks[1]
      ip_protocol = "-1"
      description = "Allow all protocol from VPC B"
    }
  }

  egress_rules = {
    all = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "-1"
    }
  }

  tags = local.tags
}

module "vpc_b_private_sg" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/security?ref=v1.0.0"

  vpc_id              = module.vpc_b.vpc_id
  security_group_name = "${module.vpc_b.vpc_name}-private-sg"
  description         = "Allow all traffic from both VPCs"

  ingress_rules = {
    vpc_a = {
      cidr_ipv4   = var.cidr_blocks[0]
      ip_protocol = "-1"
      description = "Allow all protocol from VPC A"
    },
    vpc_b = {
      cidr_ipv4   = var.cidr_blocks[1]
      ip_protocol = "-1"
      description = "Allow all protocol from VPC B"
    }
  }

  egress_rules = {
    all = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "-1"
    }
  }

  tags = local.tags
}

# VPC Peering
module "vpc_peering" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/peering?ref=v1.0.0"

  requester_vpc_id          = module.vpc_a.vpc_id
  accepter_vpc_id           = module.vpc_b.vpc_id
  requester_vpc_name        = module.vpc_a.vpc_name
  accepter_vpc_name         = module.vpc_b.vpc_name
  requester_cidr_block      = module.vpc_a.vpc_cidr_block
  accepter_cidr_block       = module.vpc_b.vpc_cidr_block
  requester_route_table_ids = [module.vpc_a.private_route_table_id]
  accepter_route_table_ids  = [module.vpc_b.private_route_table_id]
  auto_accept               = true
  tags                      = local.tags
}

# EC2 Instances
module "public_a_instance" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/ec2?ref=v1.0.0"

  ami_id                      = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc_a_public_subnet.subnet_id
  security_group_ids          = [module.vpc_a_public_sg.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  instance_name               = "${module.vpc_a.vpc_name}-public-a"
  tags                        = local.tags
}

module "private_a_instance" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/ec2?ref=v1.0.0"

  ami_id                      = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc_a_private_subnet.subnet_id
  security_group_ids          = [module.vpc_a_private_sg.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = false
  instance_name               = "${module.vpc_a.vpc_name}-private-a"
  tags                        = local.tags
}

module "private_b_instance" {
  source = "github.com/Chideraozigbo/My-Terraform-Modules.git/modules/ec2?ref=v1.0.0"

  ami_id                      = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc_b_private_subnet.subnet_id
  security_group_ids          = [module.vpc_b_private_sg.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = false
  instance_name               = "${module.vpc_b.vpc_name}-private-b"
  tags                        = local.tags
}
