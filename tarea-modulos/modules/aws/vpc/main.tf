resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = merge(var.vpc_tags, { "Name" = var.vpc_name })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.vpc_igw_tags, { "Name" = "${var.vpc_name}-igw" })
}

### start subnets  ###
resource "aws_subnet" "subnet_public" {
  for_each = var.vpc_subnets_public

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = merge(var.vpc_subnet_tags, { Name = "${var.vpc_name}-public-${each.key}" })
}

resource "aws_subnet" "subnet_private" {
  for_each = var.vpc_subnets_private

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(var.vpc_subnet_tags, { Name = "${var.vpc_name}-private-${each.key}" })
}

### end subnets ###

### start nat gateway ###
resource "aws_eip" "eip" {
  vpc = true
  tags = var.vpc_tags
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id = values(aws_subnet.subnet_public)[0].id
  tags   = merge(var.vpc_nat_gw_tags, { "Name" = "${var.vpc_name}-natgw" })
}

### end nat gateway ###

### start route table ###
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.vpc_tags, { Name = "${var.vpc_name}-rt-public" })
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = merge(var.vpc_tags, { Name = "${var.vpc_name}-rt-private" })
}

resource "aws_route_table_association" "rt_public_association" {
  count = length(aws_subnet.subnet_public)
  route_table_id = aws_route_table.rt_public.id
  subnet_id      = values(aws_subnet.subnet_public)[count.index].id
  depends_on = [aws_subnet.subnet_public, aws_route_table.rt_public]
}

resource "aws_route_table_association" "rt_private_association" {
  count = length(aws_subnet.subnet_private)
  route_table_id = aws_route_table.rt_private.id
  subnet_id      = values(aws_subnet.subnet_private)[count.index].id
  depends_on = [aws_subnet.subnet_private, aws_route_table.rt_private]
}

### end route table ###
