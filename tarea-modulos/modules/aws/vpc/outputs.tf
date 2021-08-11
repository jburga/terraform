output "this_vpc_id" {
  value = aws_vpc.this.id
}

output "this_sub_pub" {
  value = [for p in aws_subnet.this_sub_pub : p.id]
}

output "this_sub_pri" {
  value = [for p in aws_subnet.this_sub_pri : p.id]
}
