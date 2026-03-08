output "app_tg_arn" {
  description = "The ARN of the application target group."
  value       = aws_lb_target_group.app_tg.arn
}
output "lb_sg_id" {
  description = "The ID of the load balancer security group."
  value       = aws_security_group.lb_sg.id
}
