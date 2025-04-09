resource "aws_security_group" "sg" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.security_group_name
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each          = var.ingress_rules
  
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = each.value.ip_protocol
  description       = lookup(each.value, "description", null)
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  for_each          = var.egress_rules
  
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = each.value.ip_protocol
  description       = lookup(each.value, "description", null)
}