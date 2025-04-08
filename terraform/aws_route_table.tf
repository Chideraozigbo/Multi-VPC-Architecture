# route table for public subnet in vpc a

resource "aws_route_table" "vpc-a-rt-public" {
  vpc_id = aws_vpc.vpcs[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-a-igw.id
  }

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-igw-rt"
    environment = var.environment
    project     = var.project-name
  }

}

# associating the route table to the public subnet in vpc a

resource "aws_route_table_association" "vpc-rt-ass" {
  subnet_id      = aws_subnet.vpc-a-subnet.id
  route_table_id = aws_route_table.vpc-a-rt-public.id

}

# route table for private subnet in vpc a
resource "aws_route_table" "vpc-a-rt-private" {
  vpc_id = aws_vpc.vpcs[0].id

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-private-rt"
    environment = var.environment
    project     = var.project-name
  }
}

resource "aws_route_table_association" "vpc-a-private-assoc" {
  subnet_id      = aws_subnet.vpc-b-subnet.id
  route_table_id = aws_route_table.vpc-a-rt-private.id
}

# route table for private subnet in vpc b
resource "aws_route_table" "vpc-b-rt-private" {
  vpc_id = aws_vpc.vpcs[1].id

  tags = {
    Name        = "${aws_vpc.vpcs[1].tags["Name"]}-private-rt"
    environment = var.environment
    project     = var.project-name
  }
}

resource "aws_route_table_association" "vpc-b-private-assoc" {
  subnet_id      = aws_subnet.vpc-c-subnet.id
  route_table_id = aws_route_table.vpc-b-rt-private.id
}

# Route table update for VPC A to reach VPC B
resource "aws_route" "vpc-a-to-vpc-b" {
  route_table_id         = aws_route_table.vpc-a-rt-private.id
  destination_cidr_block = var.cidr-blocks[1]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Route table update for VPC B to reach VPC A
resource "aws_route" "vpc-b-to-vpc-a" {
  route_table_id         = aws_route_table.vpc-b-rt-private.id
  destination_cidr_block = var.cidr-blocks[0]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}