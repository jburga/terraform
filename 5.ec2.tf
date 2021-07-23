resource "aws_instance" "ac-xl-ec2-bastion-jburga" {
  ami = var.ami-id-ec2-aws
  instance_type = var.instance-type
  subnet_id = aws_subnet.ac-xl-public-a-jburga.id
  vpc_security_group_ids = [
    aws_security_group.ac-xl-sg-bastion-jburga.id
  ]
  key_name = var.key-name-ssh
  tags = {
    "Name" = "ac-xl-ec2-bastion-jburga"
  }
}

resource "aws_instance" "ac-xl-ec2-apache-a-jburga" {
  ami = var.ami-id-ec2-aws
  instance_type = var.instance-type
  subnet_id = aws_subnet.ac-xl-private-a-jburga.id
  vpc_security_group_ids = [
    aws_security_group.ac-xl-sg-ec2-jburga.id
  ]
  key_name = var.key-name-ssh
  user_data = file("${path.module}/scripts/apache.sh")
  tags = {
    "Name" = "ac-xl-ec2-apache-a-jburga"
  }
}

resource "aws_instance" "ac-xl-ec2-apache-b-jburga" {
  ami = var.ami-id-ec2-aws
  instance_type = var.instance-type
  subnet_id = aws_subnet.ac-xl-private-b-jburga.id
  vpc_security_group_ids = [
    aws_security_group.ac-xl-sg-ec2-jburga.id
  ]
  key_name = var.key-name-ssh
  user_data = file("${path.module}/scripts/apache.sh")
  tags = {
    "Name" = "ac-xl-ec2-apache-b-jburga"
  }
}

output "ec2_bastion" {
  value = aws_instance.ac-xl-ec2-bastion-jburga.public_ip
}

output "ec2_a" {
  value = aws_instance.ac-xl-ec2-apache-a-jburga.private_ip
}

output "ec2_b" {
  value = aws_instance.ac-xl-ec2-apache-b-jburga.private_ip
}
