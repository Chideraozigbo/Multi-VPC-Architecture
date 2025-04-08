resource "aws_vpc" "vpcs" {
  count      = length(var.cidr-blocks)
  cidr_block = var.cidr-blocks[count.index]

  tags = {
    Name        = var.vpc-name[count.index]
    environment = var.environment
    project     = var.project-name
  }
}
