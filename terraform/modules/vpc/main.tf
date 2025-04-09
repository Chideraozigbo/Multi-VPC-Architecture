resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = merge(
    var.tags,
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_internet_gateway" "igw" {
  count = var.create_igw ? 1 : 0
  
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-igw"
    }
  )
}

resource "aws_route_table" "public" {
  count = var.create_igw ? 1 : 0
  
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-public-rt"
    }
  )
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_igw ? 1 : 0
  
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-private-rt"
    }
  )
}