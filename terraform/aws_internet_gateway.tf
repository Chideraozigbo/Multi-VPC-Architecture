# internet gateway attached vpc a
resource "aws_internet_gateway" "vpc-a-igw" {
  vpc_id = aws_vpc.vpcs[0].id

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-igw"
    environment = var.environment
    project     = var.project-name
  }

}
