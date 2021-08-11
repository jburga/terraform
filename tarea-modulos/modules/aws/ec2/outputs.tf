output "sg_id" {
  value = aws_security_group.sg.id
}

output "ec2_instances_id" {
  value = [for p in aws_instance.instance : p.id]
}
