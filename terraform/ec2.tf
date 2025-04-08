resource "aws_instance" "public-a" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc-a-subnet.id
  vpc_security_group_ids = [aws_security_group.vpc-a-public-sg.id]
  key_name               = var.key_name

  associate_public_ip_address = true

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-public-a"
    environment = var.environment
    project     = var.project-name
  }
}

resource "aws_instance" "private-a" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc-b-subnet.id
  vpc_security_group_ids = [aws_security_group.vpc-a-private-sg.id]
  key_name               = var.key_name

  associate_public_ip_address = false

  tags = {
    Name        = "${aws_vpc.vpcs[0].tags["Name"]}-private-a"
    environment = var.environment
    project     = var.project-name
  }
}


resource "aws_instance" "private-b" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc-c-subnet.id
  vpc_security_group_ids = [aws_security_group.vpc-b-private-sg.id]
  key_name               = var.key_name

  associate_public_ip_address = false

  tags = {
    Name        = "${aws_vpc.vpcs[1].tags["Name"]}-private-b"
    environment = var.environment
    project     = var.project-name
  }
}
