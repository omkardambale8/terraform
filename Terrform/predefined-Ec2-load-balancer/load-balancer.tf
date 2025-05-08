resource "aws_lb" "loadbalancer1" {
 name = "loadbalancer12"
 internal = false
 load_balancer_type = "application"
 subnets = [aws_subnet.pub-subnet1.id, aws_subnet.pub-subnet2.id]
security_groups = [aws_security_group.sg.id]
tags = {
  Name= "aws-lb-new"
}
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.loadbalancer1.arn
  protocol = "HTTP"
  port = 80
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target-grp-lb.arn
  }
}