# creating security group for public subnet in vpc a
resource "aws_security_group" "vpc-a-public-sg" {
  name        = "${aws_vpc.vpcs[0].tags["Name"]}-public-sg"
  description = "Allow ssh inbound traffic from the internet and all protocols outbound traffic"
  vpc_id      = aws_vpc.vpcs[0].id

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-public-sg"
    environment = var.environment
    project     = var.project-name
  }

}

resource "aws_vpc_security_group_ingress_rule" "vpc-a-ingress" {
  security_group_id = aws_security_group.vpc-a-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = "22"
  description       = "Allow ssh from anywhere"

}

resource "aws_vpc_security_group_egress_rule" "vpc-a-egress" {
  security_group_id = aws_security_group.vpc-a-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


# creating security group for private subnet in vpc a
resource "aws_security_group" "vpc-a-private-sg" {
  name        = "${aws_vpc.vpcs[0].tags["Name"]}-private-sg"
  description = "Allow ssh inbound traffic from the internet and all protocols outbound traffic"
  vpc_id      = aws_vpc.vpcs[0].id

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-private-sg"
    environment = var.environment
    project     = var.project-name
  }

}

resource "aws_vpc_security_group_ingress_rule" "vpc-a-ingress-1" {
  security_group_id = aws_security_group.vpc-a-private-sg.id
  cidr_ipv4         = var.cidr-blocks[0]
  ip_protocol       = "-1"
  description       = "Allow all protocol from VPC A"

}

resource "aws_vpc_security_group_ingress_rule" "vpc-a-ingress-2" {
  security_group_id = aws_security_group.vpc-a-private-sg.id
  cidr_ipv4         = var.cidr-blocks[1]
  ip_protocol       = "-1"
  description       = "Allow all protocol from VPC B"

}

resource "aws_vpc_security_group_egress_rule" "vpc-a-egress-1" {
  security_group_id = aws_security_group.vpc-a-private-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# creating security group for private subnet in vpc b
resource "aws_security_group" "vpc-b-private-sg" {
  name        = "${aws_vpc.vpcs[1].tags["Name"]}-private-sg"
  description = "Allow ssh inbound traffic from the internet and all protocols outbound traffic"
  vpc_id      = aws_vpc.vpcs[1].id

  tags = {
    Name        = "${aws_vpc.vpcs[1].tags["Name"]}-private-sg"
    environment = var.environment
    project     = var.project-name
  }

}

resource "aws_vpc_security_group_ingress_rule" "vpc-b-ingress-1" {
  security_group_id = aws_security_group.vpc-b-private-sg.id
  cidr_ipv4         = var.cidr-blocks[0]
  ip_protocol       = "-1"
  description       = "Allow all protocol from VPC A"

}

resource "aws_vpc_security_group_ingress_rule" "vpc-b-ingress-2" {
  security_group_id = aws_security_group.vpc-b-private-sg.id
  cidr_ipv4         = var.cidr-blocks[1]
  ip_protocol       = "-1"
  description       = "Allow all protocol from VPC B"

}

resource "aws_vpc_security_group_egress_rule" "vpc-b-egress-1" {
  security_group_id = aws_security_group.vpc-b-private-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}