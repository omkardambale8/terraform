resource "aws_security_group" "s_group" {
  vpc_id = aws_vpc.myvpc.id
  name = "NLB-SG"
  description = "Allow NLB traffic to EC2 (port 80)"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [aws_vpc.myvpc.cidr_block]
  }



  egress {
    
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}