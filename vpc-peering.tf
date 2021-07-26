resource "aws_vpc" "ac-xl-vpc-jburga2" {
  cidr_block = "20.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "ac-xl-vpc-jburga2",
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_subnet" "ac-xl-public-a-jburga2" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga2.id
  cidr_block = "20.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "ac-xl-public-a-jburga2"
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_internet_gateway" "ac-xl-igw-jburga2" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga2.id
  tags = {
    Name = "ac-xl-igw-jburga2"
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_route_table" "ac-xl-rt-public-jburga2" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ac-xl-igw-jburga2.id
  }
  tags = {
    Name = "ac-xl-rt-public-jburga2"
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_route_table_association" "public-rt-a-association2" {
  route_table_id = aws_route_table.ac-xl-rt-public-jburga2.id
  subnet_id = aws_subnet.ac-xl-public-a-jburga2.id
}

resource "aws_security_group" "ac-xl-sg-bastion-jburga2" {
  name = "ac-xl-sg-bastion-jburga2"
  description = "security group bastion other VPC"
  vpc_id = aws_vpc.ac-xl-vpc-jburga2.id

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

resource "aws_instance" "ac-xl-ec2-external-bastion-jburga" {
  ami = var.ami-id-ec2-aws
  instance_type = var.instance-type
  subnet_id = aws_subnet.ac-xl-public-a-jburga2.id
  vpc_security_group_ids = [
    aws_security_group.ac-xl-sg-bastion-jburga2.id
  ]
  key_name = var.key-name-ssh
  tags = {
    "Name" = "ac-xl-ec2-external-bastion-jburga"
    "env" = "ac-xl-terr-lab-1"
  }
}

resource "aws_vpc_peering_connection" "ac-xl-vpc-peering-jburga" {
  peer_owner_id = var.peer-owner-id
  peer_vpc_id   = aws_vpc.ac-xl-vpc-jburga.id
  vpc_id        = aws_vpc.ac-xl-vpc-jburga2.id
  auto_accept   = true

  tags = {
    Name = "ac-xl-vpc-peering-jburga"
    "env" = "ac-xl-terr-lab-1"
  }
}
