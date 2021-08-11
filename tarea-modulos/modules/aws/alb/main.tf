resource "aws_lb" "alb" {
  name = var.lb_name
  security_groups = [aws_security_group.sg.id]
  subnets = var.lb_subnets
  load_balancer_type = var.lb_type
  internal = var.lb_internal
  enable_http2 = var.lb_enable_http2
  enable_deletion_protection = var.lb_enable_deletion_protection
  tags = merge({ "Name": var.lb_name }, var.lb_tags)
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = var.lb_listener_port
  protocol = var.lb_listener_protocol

  default_action {
    type = var.lb_listener_type
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}

resource "aws_lb_target_group" "lb_tg" {
  name = var.lb_tg_name
  port = var.lb_tg_port
  protocol = var.lb_tg_protocol
  vpc_id = var.vpc_id

  health_check {
    interval = 60
    timeout = 30
    port = var.lb_tg_port
  }
  tags = merge({ "Name": var.lb_tg_name }, var.lb_tg_tags)
}


resource "aws_lb_target_group_attachment" "tga" {
  for_each = var.ec2_instances_id

  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id = each.value
  port = var.lb_tga_port
}

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

resource "aws_security_group_rule" "ingress" {
  for_each = var.sg_ingress

  from_port = each.value.port
  to_port = each.value.port
  cidr_blocks = each.value.cidr_blocks
  protocol = each.value.protocol
  type = "ingress"
  security_group_id = aws_security_group.sg.id
}
