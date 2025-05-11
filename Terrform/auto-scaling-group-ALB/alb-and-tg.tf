#creating target group

resource "aws_lb_target_group" "ASG-tg" {
  name = "ASG-tg"
  port = 80
  protocol = "HTTP"
  # ip_address_type = "IPv4"
  vpc_id = aws_vpc.asg-vpc.id
  protocol_version = "HTTP1"
  target_type = "instance"
  tags = {
    Name="ASG-tg-tags"
  }
}

resource "aws_lb" "ASG_lb" {
  load_balancer_type = "application"
  name = "ASG-lb"
  internal = false
  # ip_address_type = "IPv4"
  subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  security_groups = [aws_security_group.ASG-sg.id]
}

resource "aws_lb_listener" "ASG-listener" {
  protocol = "HTTP"
  port = 80
  load_balancer_arn = aws_lb.ASG_lb.arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ASG-tg.id
  }
}