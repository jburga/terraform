/*** Public Resources ***/
resource "aws_internet_gateway" "ac-xl-igw-jburga" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  tags = {
    Name = "ac-xl-igw-jburga"
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_eip" "ac-xl-eip-ngw-jburga" {
  vpc = true
  depends_on = [
    aws_internet_gateway.ac-xl-igw-jburga
  ]
}

resource "aws_nat_gateway" "ac-xl-ngw-jburga" {
  allocation_id = aws_eip.ac-xl-eip-ngw-jburga.id
  subnet_id = aws_subnet.ac-xl-public-a-jburga.id
  tags = {
    Name = "ac-xl-ngw-jburga"
    env = "ac-xl-terr-lab-1"
  }
  depends_on = [
    aws_internet_gateway.ac-xl-igw-jburga,
    aws_eip.ac-xl-eip-ngw-jburga
  ]
}

resource "aws_route_table" "ac-xl-rt-public-jburga" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ac-xl-igw-jburga.id
  }
  tags = {
    Name = "ac-xl-rt-public-jburga"
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_route_table_association" "public-rt-a-association" {
  route_table_id = aws_route_table.ac-xl-rt-public-jburga.id
  subnet_id = aws_subnet.ac-xl-public-a-jburga.id
}

resource "aws_route_table_association" "public-rt-b-association" {
  route_table_id = aws_route_table.ac-xl-rt-public-jburga.id
  subnet_id = aws_subnet.ac-xl-public-b-jburga.id
}

/*** Private Resources ***/

resource "aws_route_table" "ac-xl-rt-private-jburga" {
  vpc_id = aws_vpc.ac-xl-vpc-jburga.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ac-xl-ngw-jburga.id
  }
  tags = {
    Name = "ac-xl-rt-private-jburga"
    env = "ac-xl-terr-lab-1"
  }
}

resource "aws_route_table_association" "private-rt-a-association" {
  route_table_id = aws_route_table.ac-xl-rt-private-jburga.id
  subnet_id = aws_subnet.ac-xl-private-a-jburga.id
}

resource "aws_route_table_association" "private-rt-b-association" {
  route_table_id = aws_route_table.ac-xl-rt-private-jburga.id
  subnet_id = aws_subnet.ac-xl-private-b-jburga.id
}
