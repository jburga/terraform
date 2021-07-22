provider "aws" {
  region = "us-east-1"
  profile = "jennifer-burga"
}

 data "aws_vpc" "vpc_academy" {
    id = "${var.vpc_main}"
}

 variable "hola" {
    description = "int-gateway"
    default = "igw-0feb0ed66fddac3cf"
  }
# // create VPC
#     resource "aws_vpc" "ac-xl-vpc-jburga" {
#       cidr_block = "170.100.0.0/24"
#       enable_dns_hostnames = true
#       tags = {
#           Name = "ac-xl-vpc-jburga",
#           env = "ac-xl-terr-lab-1"
#       }
#     }

  // create subnet
  resource "aws_subnet" "ac-xl-public-jburga-1" {
      vpc_id = "${data.aws_vpc.vpc_academy.id}"
      cidr_block = "10.0.3.0/24"
      map_public_ip_on_launch = true
      availability_zone = "us-east-1a"
      tags = {
          Name = "ac-xl-public-jburga-1"
          env = "ac-xl-terr-lab-1"
      }
  }
 // create gateway
  data "aws_internet_gateway" "ac-xl-igw-jburga" {
  filter {
    name   = "attachment.vpc-id"
    values = ["${data.aws_vpc.vpc_academy.id}"]
  }
}
  // create route table
  resource "aws_route_table" "ac-xl-rot-jburga-pub-1" {
    vpc_id = "${data.aws_vpc.vpc_academy.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${var.hola}"
    }
    tags = {
          Name = "ac-xl-rot-jburga-pub-1"
          env = "ac-xl-terr-lab-1"
      }
  }
  // create route table association
  resource "aws_route_table_association" "sub-ac-xl-public-jburga-1-to-rot-ac-xl-rot-jburga-pub-1" {
    route_table_id = "${aws_route_table.ac-xl-rot-jburga-pub-1.id}"
    subnet_id = "${aws_subnet.ac-xl-public-jburga-1.id}"
  }


  /// Security Groups

  resource "aws_security_group" "ac-xl-sg-jburga-1" {
    name = "ac-xl-sg-jburga-1"
    description = "ac-xl-sg-jburga-1"
    vpc_id = "${data.aws_vpc.vpc_academy.id}"
    ingress = "${var.ingress-ac-xl-sg-tmp}"

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
      "owner" = "terraform"
      "env" =  "ac-xl-terr-lab-1"
    }
  }
  /// Ec2
  resource "aws_instance" "ac-xl-ec2-jburga" {
    ami = "${var.ami-id-ec2-aws}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.ac-xl-public-jburga-1.id}"
    security_groups = ["${aws_security_group.ac-xl-sg-jburga-1.id}"]
    key_name = "${var.key-name-ssh}"
    user_data = "${file("${path.module}/scripts/hola.sh")}"

    tags = {
      "Name" = "ac-xl-ec2-jburga"
    }
  }
  