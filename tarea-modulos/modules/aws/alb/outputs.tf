output "lb_arn" {
  value = aws_lb.alb.arn
}

output "tg_arn" {
  value = aws_lb_target_group.lb_tg.arn
}

output "sg_id" {
  value = aws_security_group.sg.id
}
