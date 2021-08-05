resource "aws_security_group" "this_app" {
    vpc_id = var.vpc_id
    name = "${var.ec2_name_default}-sg-app"
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    }
}



resource "aws_instance" "this_bastion" {
  ami                         = var.ec2_ami
  instance_type               = var.bastion_type_instance
  subnet_id                   = var.sub_pub_ids[0]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags                        = merge(var.tags, { Name = "${var.ec2_name_default}-bastion" })
}

resource "aws_instance" "this_app" {
  for_each = { for v in var.sub_pri_ids : v => v}
  ami                         = var.ec2_ami
  instance_type               = var.type_instance
  subnet_id                   = each.value
  key_name                    = var.key_name
  security_groups = [aws_security_group.this_app.id]
  tags                        = merge(var.tags, { Name = "${var.ec2_name_default}-inst" })
}
