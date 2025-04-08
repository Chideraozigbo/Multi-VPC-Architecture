# VPC Peering connection
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = aws_vpc.vpcs[0].id
  peer_vpc_id = aws_vpc.vpcs[1].id
  auto_accept = true

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-to-${aws_vpc.vpcs[1].tags["Name"]}-peering"
    environment = var.environment
    project     = var.project-name
  }

}
