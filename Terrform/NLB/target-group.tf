resource "aws_lb_target_group" "targetgroup-lb-nlb" {
  name = "targetgroup-lb-nlb"
  protocol = "TCP"
 #ip_address_type = "iPv4"
  vpc_id = aws_vpc.myvpc.id
  protocol_version = "HTTP1"
  target_type = "instance"
  port = 80
  tags = {
    Name="ASG-tg-tags"
  }
}

resource "aws_lb" "NLB-lb" {
  load_balancer_type = "network"
  name = "NLB-instances"
  internal = false
 # ip_address_type = "iPv4"
  subnets =[aws_subnet.subnet1.id,aws_subnet.subnet2.id]
  security_groups = [ aws_security_group.s_group.id ]
}


resource "aws_lb_listener" "listner1" {
  protocol = "TCP"
  port = 80
  load_balancer_arn = aws_lb.NLB-lb.arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.targetgroup-lb-nlb.arn
  }

}