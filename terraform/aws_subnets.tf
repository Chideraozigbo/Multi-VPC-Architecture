# creating public subnet for VPC A
resource "aws_subnet" "vpc-a-subnet" {
  vpc_id                  = aws_vpc.vpcs[0].id
  cidr_block              = "10.10.0.0/28"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-public"
    environment = var.environment
    project     = var.project-name
  }

}

# creating private subnet for VPC A
resource "aws_subnet" "vpc-b-subnet" {
  vpc_id                  = aws_vpc.vpcs[0].id
  cidr_block              = "10.10.0.16/28"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-private"
    environment = var.environment
    project     = var.project-name
  }

}

# creating private subnet for VPC B
resource "aws_subnet" "vpc-c-subnet" {
  vpc_id                  = aws_vpc.vpcs[1].id
  cidr_block              = "10.100.0.0/28"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "${aws_vpc.vpcs[1].tags["Name"]}-private"
    environment = var.environment
    project     = var.project-name
  }

}
