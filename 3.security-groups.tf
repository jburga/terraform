resource "aws_security_group" "ac-xl-sg-bastion-jburga" {
  name = "ac-xl-sg-bastion-jburga"
  description = "security group bastion"
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "owner" = "terraform"
    "env" = "ac-xl-terr-lab-1"
  }
}

resource "aws_security_group" "ac-xl-sg-alb-jburga" {
  name = "ac-xl-sg-alb-jburga"
  description = "security group alb"
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "owner" = "terraform"
    "env" = "ac-xl-terr-lab-1"
  }
}

resource "aws_security_group" "ac-xl-sg-ec2-jburga" {
  name = "ac-xl-sg-ec2-jburga"
  description = "security group for private ec2"
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    security_groups = [aws_security_group.ac-xl-sg-bastion-jburga.id]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    security_groups = [
      aws_security_group.ac-xl-sg-alb-jburga.id,
      aws_security_group.ac-xl-sg-bastion-jburga.id
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "owner" = "terraform"
    "env" = "ac-xl-terr-lab-1"
  }
}
