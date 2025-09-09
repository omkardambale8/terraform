resource "aws_instance" "myec2" {
  ami= "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  key_name = aws_key_pair.example.id
  subnet_id = aws_subnet.public-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.aws-sg.id
  ]

  tags = {
    Name= "My-EC2"
  }
}


resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = tls_private_key.example.public_key_openssh
}

output "private_key_pem" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

resource "aws_security_group" "aws-sg" {
  vpc_id = aws_vpc.myvpc.id
  ingress {
    #http protocol
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    #ssh protocol
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 } 
 tags = {
   Name= "NATSG"
 }
}
