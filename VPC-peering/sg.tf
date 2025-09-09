resource "aws_security_group" "sga" {
  name = "a-sg"
  vpc_id = aws_vpc.vpc1.id
  ingress {
    protocol = "tcp"
    to_port = "22"
    from_port = "22"
    cidr_blocks = [aws_vpc.vpc2.cidr_block]

  }
  ingress {
    protocol = "icmp"
    to_port = "-1"
    from_port = "-1"
    cidr_blocks = [aws_vpc.vpc2.cidr_block]

  }

  egress {
    to_port = "0"
    from_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_security_group" "sgb" {
  name = "b-sg"
  vpc_id = aws_vpc.vpc2.id
ingress {
    protocol = "tcp"
    to_port = "22"
    from_port = "22"
    cidr_blocks = [aws_vpc.vpc1.cidr_block]

  }
  ingress {
    protocol = "icmp"
    to_port = "-1"
    from_port = "-1"
    cidr_blocks = [aws_vpc.vpc1.cidr_block]

  }

  egress {
    to_port = "0"
    from_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
}