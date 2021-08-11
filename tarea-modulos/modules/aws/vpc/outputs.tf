output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets_public" {
  value = [for p in aws_subnet.subnet_public : p.id]
}

output "subnets_private" {
  value = [for p in aws_subnet.subnet_private : p.id]
}
