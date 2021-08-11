resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge({ "Name": var.sg_name }, var.sg_tags)
}

resource "aws_security_group_rule" "ingress_sg" {
  for_each = var.sg_ingress_sg

  source_security_group_id = each.value.sg_id
  from_port = each.value.port
  to_port = each.value.port
  protocol = each.value.protocol
  type = "ingress"
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ingress_cidr" {
  for_each = var.sg_ingress_cidr

  from_port = each.value.port
  to_port = each.value.port
  cidr_blocks = each.value.cidr_blocks
  protocol = each.value.protocol
  type = "ingress"
  security_group_id = aws_security_group.sg.id
}


resource "aws_instance" "instance" {
  for_each = var.ec2_subnets_id

  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id = each.value
  key_name = var.ec2_key_name
  user_data = var.ec2_user_data
  tags = merge({ "Name": var.ec2_name }, var.ec2_tags)
}
