resource "aws_instance" "ec2_a" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 for us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-vpc1.id
    associate_public_ip_address = true

  security_groups = [aws_security_group.sga.id]

  key_name      = "NAT"
    tags={
        Name= "ec2_a"
    }

}

resource "aws_instance" "ec2_b" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 for us-east-1
  instance_type = "t2.micro"
  associate_public_ip_address = true

  subnet_id     = aws_subnet.subnet-vpc2.id
  key_name      = "NAT"
  security_groups = [aws_security_group.sgb.id]
    tags={
        Name= "ec2_2"
    }

}