resource "aws_alb" "ac-xl-alb-jburga" {
  name = "ac-xl-alb-jburga"
  security_groups = [
    aws_security_group.ac-xl-sg-alb-jburga.id
  ]
  subnets = [
    aws_subnet.ac-xl-public-a-jburga.id,
    aws_subnet.ac-xl-public-b-jburga.id
  ]
  load_balancer_type = "application"
  internal = false
  enable_http2 = true
  enable_deletion_protection = false
  tags = {
    Name = "ac-xl-alb-jburga",
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.ac-xl-alb-jburga.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ac-xl-tg-jburga.arn
  }
}

resource "aws_lb_target_group" "ac-xl-tg-jburga" {
  name = "ac-xl-tg-jburga"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  health_check {
    interval = 60
    timeout = 30
    port = "80"
  }
  tags = {
    Name = "ac-xl-tg-jburga",
    env = "ac-xl-terr-lab-1"
  }
}


resource "aws_lb_target_group_attachment" "web1_tga" {
  target_group_arn = aws_lb_target_group.ac-xl-tg-jburga.arn
  target_id = aws_instance.ac-xl-ec2-apache-a-jburga.id
  port = 80
}

resource "aws_lb_target_group_attachment" "web2_tga" {
  target_group_arn = aws_lb_target_group.ac-xl-tg-jburga.arn
  target_id = aws_instance.ac-xl-ec2-apache-b-jburga.id
  port = 80
}

output "endpoint-alb" {
  value = aws_alb.ac-xl-alb-jburga.dns_name
}

output "health-check-tg" {
  value = aws_lb_target_group.ac-xl-tg-jburga.health_check
}
