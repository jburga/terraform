resource "aws_subnet" "ac-xl-public-a-jburga" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  cidr_block = "10.0.81.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "ac-xl-public-jburga-1"
    env = "ac-xl-terr-lab-1"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "ac-xl-public-b-jburga" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  cidr_block = "10.0.82.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "ac-xl-public-b-jburga"
    env = "ac-xl-terr-lab-1"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "ac-xl-private-a-jburga" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  cidr_block = "10.0.83.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "ac-xl-private-a-jburga"
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_subnet" "ac-xl-private-b-jburga" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  cidr_block = "10.0.84.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "ac-xl-private-b-jburga"
    env = "ac-xl-terr-lab-1"
  }
}
