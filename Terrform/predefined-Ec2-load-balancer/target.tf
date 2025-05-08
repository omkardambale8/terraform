resource "aws_lb_target_group" "target-grp-lb" {
  name = "target-lb"
  protocol = "HTTP"
  port = 80
  vpc_id = aws_vpc.lb-vpc.id
  target_type = "instance"
  tags = {
    Name="target-lb"
  }
}

resource "aws_lb_target_group_attachment" "attachement" {
  target_group_arn = aws_lb_target_group.target-grp-lb.arn
  target_id = aws_instance.my-instance.id
    port = 80
}